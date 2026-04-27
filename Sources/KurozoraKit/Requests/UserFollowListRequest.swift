//
//  UserFollowListRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches a user's followers or following list.
public struct UserFollowListRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let listType: UsersListType
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, listType: UsersListType) {
		self.context = context
		self.userIdentity = userIdentity
		self.listType = listType
		self._cursor = nil
		self._limit = 25
	}

	// MARK: - Modifiers
	/// Sets the pagination cursor for fetching the next page.
	public func cursor(_ cursor: PageCursor?) -> Self {
		var copy = self
		copy._cursor = cursor
		return copy
	}

	/// Sets the maximum number of items to return per page.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<UserIdentity> {
		let path: String
		if let cursor = self._cursor {
			path = cursor.urlString
		} else {
			path = self.listType == .following
				? KKEndpoint.Users.following(self.userIdentity).endpointValue
				: KKEndpoint.Users.followers(self.userIdentity).endpointValue
		}

		let request = KKRequest<ResourceCollection<UserIdentity>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit]
		)
		return try await self.context.client.send(request)
	}
}
