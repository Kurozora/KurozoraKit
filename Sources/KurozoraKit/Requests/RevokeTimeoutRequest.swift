//
//  RevokeTimeoutRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// A request that revokes the active moderation timeout on a user.
public struct RevokeTimeoutRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity) {
		self.context = context
		self.userIdentity = userIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.timeout(self.userIdentity).endpointValue,
			method: .delete,
			headers: self.context.headers
		)

		return try await self.context.client.send(request)
	}
}
