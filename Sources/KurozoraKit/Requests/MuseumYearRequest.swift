//
//  MuseumYearRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches the museum entries for a given library kind and year.
///
/// ```swift
/// let page1 = try await kurozoraKit
///     .museum(for: .shows, in: 1998)
///     .limit(50)
///     .response()
///
/// // Next page:
/// let page2 = try await kurozoraKit
///     .museum(for: .shows, in: 1998)
///     .cursor(page1.nextCursor)
///     .response()
/// ```
public struct MuseumYearRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let libraryKind: LibraryKind
	private let year: Int
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, libraryKind: LibraryKind, year: Int, limit: Int = 25) {
		self.context = context
		self.libraryKind = libraryKind
		self.year = year
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
	public func response() async throws -> ResourceCollection<MuseumEntry> {
		let path = self._cursor?.urlString ?? KKEndpoint.Museum.year(self.libraryKind, self.year).endpointValue

		let request = KKRequest<ResourceCollection<MuseumEntry>>(
			path: path,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit]
		)
		return try await self.context.client.send(request)
	}
}
