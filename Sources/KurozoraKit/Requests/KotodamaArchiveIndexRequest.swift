//
//  KotodamaArchiveIndexRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the Kotodama puzzles available to replay.
///
/// ```swift
/// let page1 = try await kurozoraKit
///     .kotodamaArchive()
///     .limit(50)
///     .response()
///
/// // Next page:
/// let page2 = try await kurozoraKit
///     .kotodamaArchive()
///     .cursor(page1.nextCursor)
///     .response()
/// ```
public struct KotodamaArchiveIndexRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, limit: Int = 25) {
		self.context = context
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

	/// Sets the maximum number of entries to return per page.
	///
	/// - Parameter limit: The number of entries to fetch.
	///
	/// - Returns: A copy of the request with the limit applied.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaArchiveEntry> {
		let path = self._cursor?.urlString ?? KKEndpoint.Minigames.Kotodama.archiveIndex.endpointValue

		let request = KKRequest<ResourceCollection<KotodamaArchiveEntry>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit]
		)
		return try await self.context.client.send(request)
	}
}
