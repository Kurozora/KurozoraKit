//
//  SeasonEpisodesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the episodes for a given season.
public struct SeasonEpisodesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let seasonIdentity: SeasonIdentity
	private var _cursor: PageCursor?
	private var _limit: Int
	private var _hideFillers: Bool

	// MARK: - Initializers
	internal init(context: RequestContext, seasonIdentity: SeasonIdentity) {
		self.context = context
		self.seasonIdentity = seasonIdentity
		self._cursor = nil
		self._limit = 25
		self._hideFillers = false
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

	/// Sets whether filler episodes should be hidden from the results.
	public func hideFillers(_ hideFillers: Bool) -> Self {
		var copy = self
		copy._hideFillers = hideFillers
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<EpisodeIdentity> {
		let parameters: [String: Any] = [
			"limit": self._limit,
			"hide_fillers": self._hideFillers ? 1 : 0
		]

		let request = KKRequest<ResourceCollection<EpisodeIdentity>>(
			path: self._cursor?.urlString ?? KKEndpoint.Shows.Seasons.episodes(self.seasonIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
