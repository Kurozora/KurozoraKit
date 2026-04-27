//
//  ToggleFollowRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that toggles the follow status for a given user.
public struct ToggleFollowRequest: Sendable {
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
	public func response() async throws -> FollowUpdateResponse {
		let request = KKRequest<FollowUpdateResponse>(
			path: KKEndpoint.Users.follow(self.userIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
