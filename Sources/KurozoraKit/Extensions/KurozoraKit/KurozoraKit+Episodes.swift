//
//  KurozoraKit+Episode.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetch the episode details for the given episode identity.
	///
	/// - Parameters:
	///    - episodeIdentity: The episode identity object of the episode for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: An ``EpisodeResponse`` with the episode details.
	public func getDetails(forEpisode episodeIdentity: EpisodeIdentity, including relationships: [String] = []) async throws -> EpisodeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<EpisodeResponse>(
			path: KKEndpoint.Episodes.details(episodeIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the suggested episodes based on the given episode identity.
	///
	/// - Parameters:
	///    - episodeIdentity: The episode identity object of the episode for which the suggestions should be fetched.
	///
	/// - Returns: An ``EpisodeResponse`` with the suggested episodes.
	public func getSuggestions(forEpisode episodeIdentity: EpisodeIdentity) async throws -> EpisodeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<EpisodeResponse>(
			path: KKEndpoint.Episodes.suggestions(episodeIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Update an episode's watch status.
	///
	/// - Parameter episodeIdentity: The episode identity object of the episode that should be marked as watched/unwatched.
	///
	/// - Returns: An ``EpisodeUpdateResponse`` with the updated watch status.
	public func updateEpisodeWatchStatus(_ episodeIdentity: EpisodeIdentity) async throws -> EpisodeUpdateResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<EpisodeUpdateResponse>(
			path: KKEndpoint.Episodes.watched(episodeIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Rate the episode with the given episode identity.
	///
	/// - Parameters:
	///    - episodeIdentity: The episode identity object of the episode which should be rated.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rate episode response.
	public func rateEpisode(_ episodeIdentity: EpisodeIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [
			"rating": score
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Episodes.rate(episodeIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given episode identity.
	///
	/// - Parameters:
	///    - episodeIdentity: The episode identity object for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the episode.
	public func getReviews(forEpisode episodeIdentity: EpisodeIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Episodes.reviews(episodeIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
