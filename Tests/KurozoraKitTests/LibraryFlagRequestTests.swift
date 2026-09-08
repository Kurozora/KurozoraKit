//
//  LibraryFlagRequestTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 08/09/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

final class LibraryFlagRequestTests: XCTestCase {
	override func setUp() {
		super.setUp()
		MockURLProtocol.reset()
	}

	override func tearDown() {
		MockURLProtocol.reset()
		super.tearDown()
	}

	// MARK: - Favorites
	func testFavoriteRequestOmitsStateByDefault() async throws {
		let body = try await self.sentBody(returning: #"{"data":{"isFavorited":true}}"#) { kurozoraKit in
			_ = try await kurozoraKit.toggleFavorite(inLibrary: .shows, itemIDs: [KurozoraItemID("7")]).response()
		}

		XCTAssertFalse(body.contains("is_favorited"))
		XCTAssertTrue(body.contains("model_ids%5B%5D=7") || body.contains("model_ids[]=7"))
	}

	func testFavoriteRequestSendsExplicitState() async throws {
		let body = try await self.sentBody(returning: #"{"data":{"isFavorited":true}}"#) { kurozoraKit in
			_ = try await kurozoraKit.toggleFavorite(inLibrary: .shows, itemIDs: [KurozoraItemID("7")]).favorited(true).response()
		}

		XCTAssertTrue(body.contains("is_favorited=1"))
	}

	// MARK: - Reminders
	func testReminderRequestSendsExplicitClearedState() async throws {
		let body = try await self.sentBody(returning: #"{"data":{"isReminded":false}}"#) { kurozoraKit in
			_ = try await kurozoraKit.toggleReminder(inLibrary: .shows, itemIDs: [KurozoraItemID("7")]).reminded(false).response()
		}

		XCTAssertTrue(body.contains("is_reminded=0"))
	}

	// MARK: - Helpers
	/// The form body the request sends.
	private func sentBody(returning json: String, perform: (KurozoraKit) async throws -> Void) async throws -> String {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil))
			return (response, Data(json.utf8))
		}

		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		let kurozoraKit = KurozoraKit(apiKey: "key", authenticationKey: "token")
		kurozoraKit.client = KKNetworkClient(baseURL: "https://api.example.test/v1/", session: URLSession(configuration: configuration))

		try await perform(kurozoraKit)

		let captured = try XCTUnwrap(MockURLProtocol.capturedRequests.last)
		return String(decoding: Self.bodyData(of: captured), as: UTF8.self)
	}

	/// The request's body.
	private static func bodyData(of request: URLRequest) -> Data {
		if let body = request.httpBody {
			return body
		}
		guard let stream = request.httpBodyStream else { return Data() }

		stream.open()
		defer { stream.close() }

		var data = Data()
		let bufferSize = 1024
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
		defer { buffer.deallocate() }

		while stream.hasBytesAvailable {
			let readCount = stream.read(buffer, maxLength: bufferSize)
			if readCount <= 0 {
				break
			}
			data.append(buffer, count: readCount)
		}
		return data
	}
}
