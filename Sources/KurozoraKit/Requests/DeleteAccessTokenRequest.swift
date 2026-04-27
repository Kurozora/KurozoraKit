//
//  DeleteAccessTokenRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes the specified access token from the user's active sessions.
public struct DeleteAccessTokenRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let accessTokenID: String

	// MARK: - Initializers
	internal init(context: RequestContext, accessTokenID: String) {
		self.context = context
		self.accessTokenID = accessTokenID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.delete(self.accessTokenID).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
