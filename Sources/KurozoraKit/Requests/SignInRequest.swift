//
//  SignInRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

/// A request that signs a user in with an email address and password.
public struct SignInRequest: Sendable {
	// MARK: - Properties
	/// The request context that carries the configuration shared with the
	/// originating ``KurozoraKit`` instance.
	private let context: RequestContext

	/// The email address used to sign in.
	private let email: String

	/// The password used to sign in.
	private let password: String

	// MARK: - Initializers
	/// Creates a request that signs a user in with the specified credentials.
	///
	/// - Parameters:
	///   - context: The request context that carries the configuration shared
	///     with the originating ``KurozoraKit`` instance.
	///   - email: The email address used to sign in.
	///   - password: The password used to sign in.
	internal init(context: RequestContext, email: String, password: String) {
		self.context = context
		self.email = email
		self.password = password
	}

	// MARK: - Execution
	/// Performs the request and returns either an authenticated session or a
	/// two-factor authentication challenge.
	///
	/// - Returns: A ``SignInResult`` describing the outcome of the attempt.
	/// - Throws: An ``APIError`` if the request fails or the response cannot be interpreted.
	@MainActor
	public func response() async throws -> SignInResult {
		#if os(watchOS)
		let parameters: [String: Any] = [
			"email": self.email,
			"password": self.password,
			"client_supports_2fa": 1
		]
		#else
		let parameters: [String: Any] = [
			"email": self.email,
			"password": self.password,
			"client_supports_2fa": 1,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]
		#endif

		let request = KKRequest<SignInAttemptResponse>(
			path: KKEndpoint.Users.signIn.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		let response = try await self.context.client.send(request)

		if response.twoFactor == true, let challengeToken = response.challengeToken {
			return .requiresTwoFactor(challengeToken: challengeToken)
		}

		if let token = response.authenticationToken, let users = response.data {
			let signInResponse = SignInResponse(data: users, authenticationToken: token)
			self.context.applySignIn(token: token, user: users.first)
			return .signedIn(signInResponse)
		}

		throw APIError(
			message: "The service returned an unexpected sign-in response.",
			response: nil,
			request: nil
		)
	}
}
