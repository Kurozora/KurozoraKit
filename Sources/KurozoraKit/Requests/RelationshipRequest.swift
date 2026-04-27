//
//  RelationshipRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches a paginated sub-resource for a parent resource.
///
/// Create a `RelationshipRequest` through typed ``KurozoraKit`` factory
/// methods like ``KurozoraKit/cast(for:)`` and call ``response()`` to execute.
///
/// ```swift
/// let cast = try await kurozoraKit
///     .cast(for: showIdentity)
///     .limit(50)
///     .response()
/// ```
public struct RelationshipRequest<Response: Decodable & Sendable>: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _reversed: Bool?

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, limit: Int = 25) {
		self.context = context
		self.endpoint = endpoint
		self._cursor = nil
		self._limit = limit
		self._reversed = nil
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

	/// Reverses the order of results.
	public func reversed(_ reversed: Bool) -> Self {
		var copy = self
		copy._reversed = reversed
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> Response {
		let path = self._cursor?.urlString ?? self.endpoint
		var query: [String: Any] = ["limit": self._limit]
		if let reversed = self._reversed {
			query["reversed"] = reversed
		}

		let request = KKRequest<Response>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
