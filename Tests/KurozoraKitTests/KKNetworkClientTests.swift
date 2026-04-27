//
//  KKNetworkClientTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

/// Stub `URLProtocol` that intercepts requests and returns pre-configured responses.
///
/// Usage: set `MockURLProtocol.requestHandler` to a closure that returns
/// `(HTTPURLResponse, Data)` for the given `URLRequest`. The protocol captures
/// the incoming `URLRequest` into `MockURLProtocol.capturedRequests` so tests
/// can assert request shape.
final class MockURLProtocol: URLProtocol, @unchecked Sendable {
	nonisolated(unsafe) static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
	nonisolated(unsafe) static var capturedRequests: [URLRequest] = []

	static func reset() {
		self.requestHandler = nil
		self.capturedRequests = []
	}

	override class func canInit(with request: URLRequest) -> Bool { true }
	override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

	override func startLoading() {
		guard let handler = Self.requestHandler else {
			self.client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
			return
		}
		Self.capturedRequests.append(self.request)
		do {
			let (response, data) = try handler(self.request)
			self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			self.client?.urlProtocol(self, didLoad: data)
			self.client?.urlProtocolDidFinishLoading(self)
		} catch {
			self.client?.urlProtocol(self, didFailWithError: error)
		}
	}

	override func stopLoading() {}
}

// MARK: - Test fixtures
private struct Echo: Codable, Sendable, Equatable {
	let message: String
}

final class KKNetworkClientTests: XCTestCase {
	override func setUp() {
		super.setUp()
		MockURLProtocol.reset()
	}

	override func tearDown() {
		MockURLProtocol.reset()
		super.tearDown()
	}

	/// Builds a `KKNetworkClient` whose `URLSession` uses `MockURLProtocol` as its
	/// sole protocol, so every request is intercepted by `MockURLProtocol.requestHandler`.
	private func makeClient() -> KKNetworkClient {
		let config = URLSessionConfiguration.ephemeral
		config.protocolClasses = [MockURLProtocol.self]
		let session = URLSession(configuration: config)
		return KKNetworkClient(baseURL: "https://api.example.test/v1/", session: session)
	}

	func testSendsGetRequestWithHeadersAndDecodesResponse() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"]))
			return (response, Data(#"{"message":"hello"}"#.utf8))
		}

		let client = self.makeClient()
		let request = KKRequest<Echo>(
			path: "echo",
			method: .get,
			headers: ["X-API-Key": "abc123"]
		)
		let echo = try await client.send(request)
		XCTAssertEqual(echo, Echo(message: "hello"))

		let captured = MockURLProtocol.capturedRequests.last
		XCTAssertEqual(captured?.httpMethod, "GET")
		XCTAssertEqual(captured?.value(forHTTPHeaderField: "X-API-Key"), "abc123")
		XCTAssertEqual(captured?.url?.absoluteString, "https://api.example.test/v1/echo")
	}

	func testThrowsAPIErrorOnNon2xxResponseWithDecodedPayload() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 422, httpVersion: "HTTP/1.1", headerFields: nil))
			let body = #"{"errors":[{"id":1,"status":422,"detail":"Invalid password","title":"Validation"}]}"#
			return (response, Data(body.utf8))
		}

		let client = self.makeClient()
		let request = KKRequest<Echo>(
			path: "error",
			method: .get,
			headers: [:]
		)

		do {
			_ = try await client.send(request)
			XCTFail("Expected APIError but send succeeded")
		} catch let error as APIError {
			XCTAssertEqual(error.statusCode, 422)
			XCTAssertEqual(error.message, "Invalid password")
		} catch {
			XCTFail("Expected APIError but got \(error)")
		}
	}

	func testAppendsQueryParametersToURL() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil))
			return (response, Data(#"{"message":"ok"}"#.utf8))
		}

		let client = self.makeClient()
		let request = KKRequest<Echo>(
			path: "list",
			method: .get,
			headers: [:],
			query: ["limit": 25, "enabled": true]
		)
		_ = try await client.send(request)

		let urlString = MockURLProtocol.capturedRequests.last?.url?.absoluteString ?? ""
		XCTAssertTrue(urlString.contains("limit=25"), "URL missing limit=25: \(urlString)")
		XCTAssertTrue(urlString.contains("enabled=1"), "URL missing enabled=1: \(urlString)")
	}

	func testFormURLEncodedBodySetsContentTypeAndBody() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil))
			return (response, Data(#"{"message":"ok"}"#.utf8))
		}

		let client = self.makeClient()
		let request = KKRequest<Echo>(
			path: "submit",
			method: .post,
			headers: [:],
			body: .formURLEncoded(["name": "kirito", "score": 42])
		)
		_ = try await client.send(request)

		let captured = try XCTUnwrap(MockURLProtocol.capturedRequests.last)
		XCTAssertEqual(captured.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
		// URLProtocol strips httpBody into httpBodyStream in some cases, so we
		// reconstruct the sent body from either source.
		let sentBody: Data = {
			if let body = captured.httpBody { return body }
			guard let stream = captured.httpBodyStream else { return Data() }
			stream.open()
			defer { stream.close() }
			var data = Data()
			let bufferSize = 1024
			let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
			defer { buffer.deallocate() }
			while stream.hasBytesAvailable {
				let read = stream.read(buffer, maxLength: bufferSize)
				if read <= 0 { break }
				data.append(buffer, count: read)
			}
			return data
		}()
		let bodyString = String(data: sentBody, encoding: .utf8) ?? ""
		XCTAssertEqual(bodyString, "name=kirito&score=42")
	}

	func testAbsoluteURLPathsAreNotResolvedAgainstBase() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil))
			return (response, Data(#"{"message":"ok"}"#.utf8))
		}

		let client = self.makeClient()
		let nextCursor = "https://api.example.test/v1/page2?cursor=xyz"
		let request = KKRequest<Echo>(
			path: nextCursor,
			method: .get,
			headers: [:]
		)
		_ = try await client.send(request)

		XCTAssertEqual(MockURLProtocol.capturedRequests.last?.url?.absoluteString, nextCursor)
	}
}
