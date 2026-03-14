//
//  KurozoraKit+Game.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/03/2023.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetch the games index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``GameIdentityResponse`` with the games index.
	public func gamesIndex(next: String? = nil, limit: Int = 5, filter: GameFilter?) async throws -> GameIdentityResponse {
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

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Games.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the game details for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``GameResponse`` with the game details.
	public func getDetails(forGame gameIdentity: GameIdentity, including relationships: [String] = []) async throws -> GameResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<GameResponse>(
			path: KKEndpoint.Games.details(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the people for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the people should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``PersonIdentityResponse`` with the people for the game.
	public func getPeople(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> PersonIdentityResponse {
		let request = KKRequest<PersonIdentityResponse>(
			path: next ?? KKEndpoint.Games.people(gameIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the cast for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the cast should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CastIdentityResponse`` with the cast for the game.
	public func getCast(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> CastIdentityResponse {
		let request = KKRequest<CastIdentityResponse>(
			path: next ?? KKEndpoint.Games.cast(gameIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the characters for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the characters should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CharacterIdentityResponse`` with the characters for the game.
	public func getCharacters(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> CharacterIdentityResponse {
		let request = KKRequest<CharacterIdentityResponse>(
			path: next ?? KKEndpoint.Games.characters(gameIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related games for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the related games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedGameResponse`` with the related games for the game.
	public func getRelatedGames(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedGameResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedGameResponse>(
			path: next ?? KKEndpoint.Games.relatedGames(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related shows for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the related shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedShowResponse`` with the related shows for the game.
	public func getRelatedShows(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedShowResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedShowResponse>(
			path: next ?? KKEndpoint.Games.relatedShows(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related literatures for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the related literatures should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedLiteratureResponse`` with the related literatures for the game.
	public func getRelatedLiteratures(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedLiteratureResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedLiteratureResponse>(
			path: next ?? KKEndpoint.Games.relatedLiteratures(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the game.
	public func getReviews(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Games.reviews(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the studios for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the studios should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``StudioIdentityResponse`` with the studios for the game.
	public func getStudios(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> StudioIdentityResponse {
		let request = KKRequest<StudioIdentityResponse>(
			path: next ?? KKEndpoint.Games.studios(gameIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the more by studio section for the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game for which the more by studio section should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the more by studio games.
	public func getMoreByStudio(forGame gameIdentity: GameIdentity, next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Games.moreByStudio(gameIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the game with the given game identity.
	///
	/// - Parameters:
	///    - gameIdentity: The identity of the game to rate.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	public func rateGame(_ gameIdentity: GameIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Games.rate(gameIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetch the upcoming games.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the upcoming games.
	public func getUpcomingGames(next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Games.upcoming.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
