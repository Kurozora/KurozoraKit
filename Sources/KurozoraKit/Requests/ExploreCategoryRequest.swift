//
//  ExploreCategoryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the content of a specific explore category.
public struct ExploreCategoryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let categoryIdentity: ExploreCategoryIdentity
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, categoryIdentity: ExploreCategoryIdentity) {
		self.context = context
		self.categoryIdentity = categoryIdentity
		self._cursor = nil
		self._limit = 5
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
	public func response() async throws -> ResourceCollection<ExploreCategory> {
		let request = KKRequest<ResourceCollection<ExploreCategory>>(
			path: self._cursor?.urlString ?? KKEndpoint.Explore.details(self.categoryIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit]
		)
		return try await self.context.client.send(request)
	}
}
