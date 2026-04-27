//
//  UserLibraryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the library entries for a given user.
public struct UserLibraryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let kind: LibraryKind
	private let status: LibraryStatus
	private var _sortType: LibrarySortType
	private var _sortOption: LibrarySortOption
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, kind: LibraryKind, status: LibraryStatus) {
		self.context = context
		self.userIdentity = userIdentity
		self.kind = kind
		self.status = status
		self._sortType = .none
		self._sortOption = .none
		self._cursor = nil
		self._limit = 25
	}

	// MARK: - Modifiers
	/// Sorts the results by the given type and direction.
	public func sorted(by sortType: LibrarySortType, _ option: LibrarySortOption) -> Self {
		var copy = self
		copy._sortType = sortType
		copy._sortOption = option
		return copy
	}

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
	public func response() async throws -> LibraryResponse {
		var query: [String: Any] = [
			"library": self.kind.rawValue,
			"status": self.status.sectionValue,
			"limit": self._limit
		]
		if self._sortType != .none {
			query["sort"] = "\(self._sortType.parameterValue)\(self._sortOption.parameterValue)"
		}

		let request = KKRequest<LibraryResponse>(
			path: self._cursor?.urlString ?? KKEndpoint.Users.library(self.userIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
