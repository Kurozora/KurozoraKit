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

/// A request that signs a user in with their email and password.
public struct SignInRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let email: String
	private let password: String

	// MARK: - Initializers
	internal init(context: RequestContext, email: String, password: String) {
		self.context = context
		self.email = email
		self.password = password
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	@MainActor
	public func response() async throws -> SignInResponse {
		#if os(watchOS)
		let parameters: [String: Any] = [
			"email": self.email,
			"password": self.password
		]
		#else
		let parameters: [String: Any] = [
			"email": self.email,
			"password": self.password,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]
		#endif

		let request = KKRequest<SignInResponse>(
			path: KKEndpoint.Users.signIn.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		let response = try await self.context.client.send(request)
		self.context.applySignIn(token: response.authenticationToken, user: response.data.first)
		return response
	}
}
