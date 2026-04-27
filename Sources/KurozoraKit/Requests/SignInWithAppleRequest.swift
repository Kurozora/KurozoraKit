//
//  SignInWithAppleRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

/// A request that signs in or registers an account using Sign in with Apple.
public struct SignInWithAppleRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let token: String

	// MARK: - Initializers
	internal init(context: RequestContext, token: String) {
		self.context = context
		self.token = token
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	@MainActor
	public func response() async throws -> OAuthResponse {
		#if os(watchOS)
		let parameters: [String: Any] = [
			"token": self.token
		]
		#else
		let parameters: [String: Any] = [
			"token": self.token,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]
		#endif

		let request = KKRequest<OAuthResponse>(
			path: KKEndpoint.Users.siwaSignIn.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		let response = try await self.context.client.send(request)
		self.context.applySignIn(token: response.authenticationToken, user: response.data?.first)
		return response
	}
}
