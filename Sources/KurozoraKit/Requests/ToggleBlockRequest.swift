//
//  ToggleBlockRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that toggles the block status for a given user.
public struct ToggleBlockRequest: Sendable {
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
	public func response() async throws -> BlockUpdateResponse {
		let request = KKRequest<BlockUpdateResponse>(
			path: KKEndpoint.Users.block(self.userIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
