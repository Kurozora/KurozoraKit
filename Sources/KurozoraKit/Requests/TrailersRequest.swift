//
//  TrailersRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches a paginated index of titles that have a trailer.
///
/// ```swift
/// let page1 = try await kurozoraKit
///     .showTrailers(sortedBy: .mostPopular)
///     .limit(25)
///     .response()
///
/// // Next page:
/// let page2 = try await kurozoraKit
///     .showTrailers(sortedBy: .mostPopular)
///     .cursor(page1.nextCursor)
///     .response()
/// ```
public struct TrailersRequest<T: Codable & Sendable>: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String
	private let sort: TrailerSort
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, sort: TrailerSort, limit: Int = 25) {
		self.context = context
		self.endpoint = endpoint
		self.sort = sort
		self._cursor = nil
		self._limit = limit
	}

	// MARK: - Modifiers
	/// Sets the pagination cursor for fetching the next page.
	///
	/// - Parameter cursor: The cursor returned by a previous response.
	///
	/// - Returns: A copy of the request with the cursor applied.
	public func cursor(_ cursor: PageCursor?) -> Self {
		var copy = self
		copy._cursor = cursor
		return copy
	}

	/// Sets the maximum number of titles to return per page.
	///
	/// - Parameter limit: The number of titles to fetch.
	///
	/// - Returns: A copy of the request with the limit applied.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<T> {
		let path = self._cursor?.urlString ?? self.endpoint

		let request = KKRequest<ResourceCollection<T>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit, "sort": self.sort.rawValue]
		)
		return try await self.context.client.send(request)
	}
}
