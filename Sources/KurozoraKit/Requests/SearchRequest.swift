//
//  SearchRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that searches the Kurozora catalog or the user's library.
///
/// Create a `SearchRequest` through the ``KurozoraKit`` factory method
/// ``KurozoraKit/search(_:types:query:)`` and call ``response()`` to execute.
///
/// ```swift
/// let results = try await kurozoraKit
///     .search(.kurozora, types: [.shows, .games], query: "Attack on Titan")
///     .limit(10)
///     .response()
/// ```
public struct SearchRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let scope: SearchScope
	private let types: [SearchType]
	private let query: String
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _filter: SearchFilter?

	// MARK: - Initializers
	internal init(context: RequestContext, scope: SearchScope, types: [SearchType], query: String) {
		self.context = context
		self.scope = scope
		self.types = types
		self.query = query
		self._cursor = nil
		self._limit = 5
		self._filter = nil
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

	/// Applies a search filter to the results.
	public func filter(_ filter: SearchFilter?) -> Self {
		var copy = self
		copy._filter = filter
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> SearchResponse {
		let path = self._cursor?.urlString ?? KKEndpoint.Search.index.endpointValue

		var parameters: [String: Any] = ["limit": self._limit]
		if self._cursor == nil {
			parameters["scope"] = self.scope.queryValue
			parameters["types"] = self.types.map { $0.rawValue }
			parameters["query"] = self.query

			if let filter = self._filter {
				var filters: [String: Any] = [:]
				switch filter {
				case .appTheme(let f as Filterable),
					 .character(let f as Filterable),
					 .episode(let f as Filterable),
					 .game(let f as Filterable),
					 .literature(let f as Filterable),
					 .person(let f as Filterable),
					 .show(let f as Filterable),
					 .song(let f as Filterable),
					 .studio(let f as Filterable),
					 .user(let f as Filterable):
					filters = f.toFilterArray().compactMapValues { $0 }
				}

				if !filters.isEmpty {
					if let filterData = try? JSONSerialization.data(withJSONObject: filters) {
						parameters["filter"] = filterData.base64EncodedString()
					}
				}
			}
		}

		let request = KKRequest<SearchResponse>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
