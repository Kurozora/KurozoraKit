//
//  UserIndexRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the global user index.
public struct UserIndexRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _sort: String?
	private var _direction: String?

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
		self._cursor = nil
		self._limit = 25
		self._sort = nil
		self._direction = nil
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

	/// Sets the sort key and direction for the request.
	///
	/// - Parameters:
	///   - sort: The sort key.
	///   - direction: The sort direction.
	public func sort(_ sort: String, direction: String) -> Self {
		var copy = self
		copy._sort = sort
		copy._direction = direction
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<UserIdentity> {
		let path = self._cursor?.urlString ?? KKEndpoint.Users.index.endpointValue
		var query: [String: Any] = ["limit": self._limit]

		if let sort = self._sort {
			if let direction = self._direction {
				query["sort"] = "\(sort)(\(direction))"
			} else {
				query["sort"] = sort
			}
		}

		let request = KKRequest<ResourceCollection<UserIdentity>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
