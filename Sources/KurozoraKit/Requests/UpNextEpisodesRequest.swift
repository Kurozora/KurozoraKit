//
//  UpNextEpisodesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's up-next episodes.
public struct UpNextEpisodesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let showIdentity: ShowIdentity?
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, showIdentity: ShowIdentity?) {
		self.context = context
		self.showIdentity = showIdentity
		self._cursor = nil
		self._limit = 25
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
	public func response() async throws -> ResourceCollection<EpisodeIdentity> {
		var parameters: [String: Any] = ["limit": self._limit]
		if let showIdentity = self.showIdentity {
			parameters["model_id"] = showIdentity.id
		}

		let request = KKRequest<ResourceCollection<EpisodeIdentity>>(
			path: self._cursor?.urlString ?? KKEndpoint.Me.Episodes.upNext.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
