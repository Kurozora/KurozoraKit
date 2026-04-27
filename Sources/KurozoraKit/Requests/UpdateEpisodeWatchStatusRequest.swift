//
//  UpdateEpisodeWatchStatusRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that toggles the watch status of an episode.
public struct UpdateEpisodeWatchStatusRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let episodeIdentity: EpisodeIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, episodeIdentity: EpisodeIdentity) {
		self.context = context
		self.episodeIdentity = episodeIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> EpisodeUpdateResponse {
		let request = KKRequest<EpisodeUpdateResponse>(
			path: KKEndpoint.Episodes.watched(self.episodeIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
