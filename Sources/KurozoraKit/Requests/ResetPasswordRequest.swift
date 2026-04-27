//
//  ResetPasswordRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that sends a password reset link to the given email address.
public struct ResetPasswordRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let emailAddress: String

	// MARK: - Initializers
	internal init(context: RequestContext, emailAddress: String) {
		self.context = context
		self.emailAddress = emailAddress
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.resetPassword.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(["email": self.emailAddress])
		)
		return try await self.context.client.send(request)
	}
}
