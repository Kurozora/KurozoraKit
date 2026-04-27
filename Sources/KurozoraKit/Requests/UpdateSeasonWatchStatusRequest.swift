//
//  UpdateSeasonWatchStatusRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that toggles the watch status of a season.
public struct UpdateSeasonWatchStatusRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let seasonIdentity: SeasonIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, seasonIdentity: SeasonIdentity) {
		self.context = context
		self.seasonIdentity = seasonIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> SeasonUpdateResponse {
		let request = KKRequest<SeasonUpdateResponse>(
			path: KKEndpoint.Shows.Seasons.watched(self.seasonIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
