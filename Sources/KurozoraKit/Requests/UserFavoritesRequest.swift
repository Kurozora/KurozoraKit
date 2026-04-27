//
//  UserFavoritesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the favorites for a given user filtered by library kind.
public struct UserFavoritesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let kind: LibraryKind
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, kind: LibraryKind) {
		self.context = context
		self.userIdentity = userIdentity
		self.kind = kind
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
	public func response() async throws -> FavoriteLibraryResponse {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"limit": self._limit
		]

		let request = KKRequest<FavoriteLibraryResponse>(
			path: self._cursor?.urlString ?? KKEndpoint.Users.favorites(self.userIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
