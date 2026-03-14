//
//  KurozoraKit+Season.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetch the season details for the given season identity.
	///
	/// - Parameters:
	///    - seasonIdentity: The identity of the season for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``SeasonResponse`` with the season details.
	public func getDetails(forSeason seasonIdentity: SeasonIdentity, including relationships: [String] = []) async throws -> SeasonResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<SeasonResponse>(
			path: KKEndpoint.Shows.Seasons.details(seasonIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the episodes for the given season identity.
	///
	/// - Parameters:
	///    - seasonIdentity: The identity of the season for which the episodes should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///    - hideFillers: A boolean indicating whether filler episodes should be hidden.
	///
	/// - Returns: An ``EpisodeIdentityResponse`` with the episodes for the season.
	public func getEpisodes(forSeason seasonIdentity: SeasonIdentity, next: String? = nil, limit: Int = 25, hideFillers: Bool = false) async throws -> EpisodeIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let parameters: [String: Any] = [
			"limit": limit,
			"hide_fillers": hideFillers ? 1 : 0
		]

		let request = KKRequest<EpisodeIdentityResponse>(
			path: next ?? KKEndpoint.Shows.Seasons.episodes(seasonIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Update a season's watch status.
	///
	/// - Parameter seasonIdentity: The identity of the season to mark as watched or unwatched.
	///
	/// - Returns: A ``SeasonUpdateResponse`` with the updated watch status.
	public func updateSeasonWatchStatus(_ seasonIdentity: SeasonIdentity) async throws -> SeasonUpdateResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<SeasonUpdateResponse>(
			path: KKEndpoint.Shows.Seasons.watched(seasonIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
