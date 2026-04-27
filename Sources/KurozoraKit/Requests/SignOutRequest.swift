//
//  SignOutRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that signs the authenticated user out.
public struct SignOutRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let accessTokenIdentifier: String

	// MARK: - Initializers
	internal init(context: RequestContext, accessTokenIdentifier: String) {
		self.context = context
		self.accessTokenIdentifier = accessTokenIdentifier
	}

	// MARK: - Execution
	/// Executes the request.
	///
	/// - Returns: A ``KKSuccess`` indicating the sign out succeeded.
	@MainActor
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.delete(self.accessTokenIdentifier).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		let response = try await self.context.client.send(request)
		self.context.applySignOut()
		return response
	}
}
