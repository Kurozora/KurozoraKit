//
//  FeedMessageReSharesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the simple re-shares for a given feed message.
public struct FeedMessageReSharesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let messageIdentity: FeedMessageIdentity
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _sort: ReSharesSortType

	// MARK: - Initializers
	internal init(context: RequestContext, messageIdentity: FeedMessageIdentity) {
		self.context = context
		self.messageIdentity = messageIdentity
		self._cursor = nil
		self._limit = 25
		self._sort = .default
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

	/// Sets the sort order for the returned re-shares.
	public func sort(_ sort: ReSharesSortType) -> Self {
		var copy = self
		copy._sort = sort
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<FeedMessage> {
		var query: [String: Any] = ["limit": self._limit]

		if let sortValue = self._sort.queryValue {
			query["sort"] = sortValue
		}

		let request = KKRequest<ResourceCollection<FeedMessage>>(
			path: self._cursor?.urlString ?? KKEndpoint.Feed.Messages.reShares(self.messageIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
