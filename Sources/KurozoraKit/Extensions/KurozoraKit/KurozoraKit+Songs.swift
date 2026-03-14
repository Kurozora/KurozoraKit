//
//  KurozoraKit+Songs.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/02/2022.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetch the songs index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``SongIdentityResponse`` with the songs index.
	func songsIndex(next: String? = nil, limit: Int = 5, filter: SongFilter?) async throws -> SongIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [
			"limit": limit,
		]

		if next == nil, let filter = filter {
			let filters: [String: Any] = filter.toFilterArray().compactMapValues { $0 }
			do {
				let filterData = try JSONSerialization.data(withJSONObject: filters, options: [])
				parameters["filter"] = filterData.base64EncodedString()
			} catch {
				print("❌ Encode error: Could not make base64 string from filter data", filters)
			}
		}

		let request = KKRequest<SongIdentityResponse>(
			path: next ?? KKEndpoint.Songs.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the song details for the given song identity.
	///
	/// - Parameters:
	///    - songIdentity: The identity of the song for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``SongResponse`` with the song details.
	func getDetails(forSong songIdentity: SongIdentity, including relationships: [String] = []) async throws -> SongResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<SongResponse>(
			path: KKEndpoint.Songs.details(songIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the shows for the given song identity.
	///
	/// - Parameters:
	///    - songIdentity: The identity of the song for which the shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` with the shows for the song.
	func getShows(forSong songIdentity: SongIdentity, next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Songs.shows(songIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the games for the given song identity.
	///
	/// - Parameters:
	///    - songIdentity: The identity of the song for which the games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the games for the song.
	func getGames(forSong songIdentity: SongIdentity, next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Songs.games(songIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the song with the given song identity.
	///
	/// - Parameters:
	///    - songIdentity: The identity of the song to rate.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	func rateSong(_ songIdentity: SongIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score,
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Songs.rate(songIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given song identity.
	///
	/// - Parameters:
	///    - songIdentity: The identity of the song for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the song.
	func getReviews(forSong songIdentity: SongIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Songs.reviews(songIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
