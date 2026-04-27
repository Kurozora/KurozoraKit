//
//  ListRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches a paginated index of resources.
///
/// Create a `ListRequest` through typed ``KurozoraKit`` factory methods
/// like ``KurozoraKit/shows()`` and call ``response()`` to execute.
///
/// ```swift
/// let page1 = try await kurozoraKit
///     .shows()
///     .limit(25)
///     .filter(myFilter)
///     .response()
///
/// // Next page:
/// let page2 = try await kurozoraKit
///     .shows()
///     .cursor(page1.nextCursor)
///     .response()
/// ```
public struct ListRequest<T: Fetchable>: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _filter: (any Filterable)?

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, limit: Int = 25) {
		self.context = context
		self.endpoint = endpoint
		self._cursor = nil
		self._limit = limit
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

	/// Applies a filter to the results.
	public func filter(_ filter: (any Filterable)?) -> Self {
		var copy = self
		copy._filter = filter
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<T> {
		let path = self._cursor?.urlString ?? self.endpoint

		var query: [String: Any] = ["limit": self._limit]
		if self._cursor == nil, let filter = self._filter {
			let filters = filter.toFilterArray().compactMapValues { $0 }
			if !filters.isEmpty {
				if let filterData = try? JSONSerialization.data(withJSONObject: filters) {
					query["filter"] = filterData.base64EncodedString()
				}
			}
		}

		let request = KKRequest<ResourceCollection<T>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
