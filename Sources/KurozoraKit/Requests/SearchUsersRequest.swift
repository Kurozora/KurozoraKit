//
//  SearchUsersRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that searches for users matching a username.
public struct SearchUsersRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let username: String

	// MARK: - Initializers
	internal init(context: RequestContext, username: String) {
		self.context = context
		self.username = username
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<UserIdentity> {
		let request = KKRequest<ResourceCollection<UserIdentity>>(
			path: KKEndpoint.Users.search(self.username).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
