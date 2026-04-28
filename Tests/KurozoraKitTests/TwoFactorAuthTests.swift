//
//  TwoFactorAuthTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 28/04/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

@MainActor
final class TwoFactorAuthTests: XCTestCase {
	// MARK: - Lifecycle
	override func setUp() {
		super.setUp()
		MockURLProtocol.reset()
	}

	override func tearDown() {
		MockURLProtocol.reset()
		super.tearDown()
	}

	// MARK: - SignInRequest routing
	/// Verifies that ``SignInRequest`` forwards the `client_supports_2fa` flag
	/// alongside the email and password payload, signaling to the service that
	/// the client can resolve a two-factor authentication challenge.
	func testSignInSendsClientSupports2FAFlag() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			return (response, Data(#"{"two_factor":true,"challenge_token":"abc"}"#.utf8))
		}

		let kit = self.makeKit()
		_ = try await kit.signIn(email: "user@example.test", password: "secret").response()

		let body = try XCTUnwrap(MockURLProtocol.capturedRequests.last.flatMap { Self.bodyData(of: $0) })
		let bodyString = String(data: body, encoding: .utf8) ?? ""
		XCTAssertTrue(bodyString.contains("client_supports_2fa=1"), "Missing 2FA capability flag in: \(bodyString)")
	}

	/// Verifies that a two-factor response is routed to
	/// ``SignInResult/requiresTwoFactor(challengeToken:)`` and that no session
	/// is recorded against the kit.
	func testSignInRoutesTwoFactorResponse() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			return (response, Data(#"{"two_factor":true,"challenge_token":"chal-xyz"}"#.utf8))
		}

		let kit = self.makeKit()
		let result = try await kit.signIn(email: "u@e.test", password: "p").response()

		switch result {
		case .signedIn:
			XCTFail("Expected .requiresTwoFactor, got .signedIn")
		case .requiresTwoFactor(let token):
			XCTAssertEqual(token, "chal-xyz")
		}

		XCTAssertEqual(kit.authenticationKey, "", "authenticationKey must not be applied for a two-factor response")
	}

	/// Verifies that a successful sign-in response is routed to
	/// ``SignInResult/signedIn(_:)``, applies the session to the kit, and
	/// surfaces the original ``SignInResponse``.
	func testSignInRoutesSuccessResponse() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			let body = #"{"data":[],"authenticationToken":"token-123"}"#
			return (response, Data(body.utf8))
		}

		let kit = self.makeKit()
		let result = try await kit.signIn(email: "u@e.test", password: "p").response()

		switch result {
		case .signedIn(let response):
			XCTAssertEqual(response.authenticationToken, "token-123")
		case .requiresTwoFactor:
			XCTFail("Expected .signedIn, got .requiresTwoFactor")
		}

		XCTAssertEqual(kit.authenticationKey, "token-123")
	}

	/// Verifies that a 200 response containing neither a token nor a challenge
	/// is surfaced as an ``APIError`` instead of being silently absorbed.
	func testSignInThrowsOnMalformedSuccessBody() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			return (response, Data(#"{"unexpected":"shape"}"#.utf8))
		}

		let kit = self.makeKit()

		do {
			_ = try await kit.signIn(email: "u@e.test", password: "p").response()
			XCTFail("Expected APIError")
		} catch is APIError {
			// expected
		} catch {
			XCTFail("Expected APIError, got \(error)")
		}
	}

	// MARK: - TwoFactorChallengeRequest validation
	/// Verifies that calling ``TwoFactorChallengeRequest/response()`` without
	/// a configured credential throws synchronously, without performing a
	/// network request.
	func testTwoFactorChallengeRequiresCredential() async throws {
		MockURLProtocol.requestHandler = { _ in
			XCTFail("Should not hit network when no credential supplied")
			throw URLError(.unknown)
		}

		let kit = self.makeKit()

		do {
			_ = try await kit.submitTwoFactorChallenge(token: "tok").response()
			XCTFail("Expected APIError")
		} catch is APIError {
			XCTAssertTrue(MockURLProtocol.capturedRequests.isEmpty)
		} catch {
			XCTFail("Expected APIError, got \(error)")
		}
	}

	/// Verifies that ``TwoFactorChallengeRequest/otp(_:)`` and
	/// ``TwoFactorChallengeRequest/recoveryCode(_:)`` are mutually exclusive,
	/// with the most recently configured credential taking effect.
	func testTwoFactorChallengeBuildersAreMutuallyExclusive() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			return (response, Data(#"{"data":[],"authenticationToken":"t"}"#.utf8))
		}

		let kit = self.makeKit()
		_ = try await kit.submitTwoFactorChallenge(token: "tok")
			.recoveryCode("aaaaaaaaaa-bbbbbbbbbb")
			.otp("123456")
			.response()

		let body = try XCTUnwrap(MockURLProtocol.capturedRequests.last.flatMap { Self.bodyData(of: $0) })
		let bodyString = String(data: body, encoding: .utf8) ?? ""

		XCTAssertTrue(bodyString.contains("otp=123456"))
		XCTAssertFalse(bodyString.contains("recovery_code"), "Both credentials should not be sent: \(bodyString)")
	}

	/// Verifies that ``TwoFactorChallengeRequest`` resolves the documented
	/// challenge endpoint path, guarding against an accidental rename of the
	/// ``KKEndpoint`` case.
	func testTwoFactorChallengeHitsExpectedPath() async throws {
		MockURLProtocol.requestHandler = { request in
			let url = try XCTUnwrap(request.url)
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
			return (response, Data(#"{"data":[],"authenticationToken":"t"}"#.utf8))
		}

		let kit = self.makeKit()
		_ = try await kit.submitTwoFactorChallenge(token: "tok").otp("123456").response()

		let url = try XCTUnwrap(MockURLProtocol.capturedRequests.last?.url?.absoluteString)
		XCTAssertTrue(url.hasSuffix("/users/two-factor-challenge"), "Unexpected URL: \(url)")
	}

	// MARK: - Helpers
	/// Returns a ``KurozoraKit`` instance whose underlying `URLSession` is
	/// wired through ``MockURLProtocol``, so every API call is routed to the
	/// in-test handler.
	private func makeKit() -> KurozoraKit {
		let kit = KurozoraKit(apiKey: "test-key")
		let config = URLSessionConfiguration.ephemeral
		config.protocolClasses = [MockURLProtocol.self]

		let session = URLSession(configuration: config)
		kit.client = KKNetworkClient(baseURL: "https://api.example.test/v1/", session: session)
		return kit
	}

	/// Returns an `HTTPURLResponse` configured with a JSON content type for
	/// the specified URL and status code.
	///
	/// - Parameters:
	///   - url: The URL associated with the response.
	///   - status: The HTTP status code of the response.
	///
	/// - Returns: A configured `HTTPURLResponse`.
	private func makeJSONResponse(url: URL, status: Int = 200) -> HTTPURLResponse {
		HTTPURLResponse(url: url, statusCode: status, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])!
	}

	/// Returns the body of a `URLRequest`, falling back to `httpBodyStream`
	/// when `URLProtocol` has consumed the in-memory body.
	///
	/// - Parameter request: The request whose body to read.
	///
	/// - Returns: The body data, or `nil` if the request has no body.
	private static func bodyData(of request: URLRequest) -> Data? {
		if let body = request.httpBody {
			return body
		}
		guard let stream = request.httpBodyStream else { return nil }
		stream.open()

		defer { stream.close() }

		var data = Data()
		let bufferSize = 1024
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)

		defer { buffer.deallocate() }

		while stream.hasBytesAvailable {
			let read = stream.read(buffer, maxLength: bufferSize)

			if read <= 0 {
				break
			}

			data.append(buffer, count: read)
		}
		return data
	}
}
