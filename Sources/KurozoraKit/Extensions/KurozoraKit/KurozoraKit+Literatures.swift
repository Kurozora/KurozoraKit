//
//  KurozoraKit+Literature.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/02/2023.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetch the literatures index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the literatures index.
	func literaturesIndex(next: String? = nil, limit: Int = 5, filter: LiteratureFilter?) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [
			"limit": limit
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

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the details for a generic `KurozoraItem` identity.
	///
	/// - Parameters:
	///    - identity: The identity of the item for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: An ``I`` response with the item details.
	func getDetails<I: KurozoraRequestable>(for identity: KurozoraItem, including relationships: [String] = []) async throws -> I {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let detailsEndpoint = if let identity = identity as? CharacterIdentity {
			KKEndpoint.Characters.details(identity).endpointValue
		} else if let identity = identity as? EpisodeIdentity {
			KKEndpoint.Episodes.details(identity).endpointValue
		} else if let identity = identity as? GameIdentity {
			KKEndpoint.Games.details(identity).endpointValue
		} else if let identity = identity as? LiteratureIdentity {
			KKEndpoint.Literatures.details(identity).endpointValue
		} else if let identity = identity as? PersonIdentity {
			KKEndpoint.People.details(identity).endpointValue
		} else if let identity = identity as? SeasonIdentity {
			KKEndpoint.Shows.Seasons.details(identity).endpointValue
		} else if let identity = identity as? ShowIdentity {
			KKEndpoint.Shows.details(identity).endpointValue
		} else if let identity = identity as? StudioIdentity {
			KKEndpoint.Studios.details(identity).endpointValue
		} else if let identity = identity as? GenreIdentity {
			KKEndpoint.Genres.details(identity).endpointValue
		} else if let identity = identity as? ThemeIdentity {
			KKEndpoint.Themes.details(identity).endpointValue
		} else if let identity = identity as? CastIdentity {
			if identity.type == "show-cast" {
				KKEndpoint.Cast.showCast(identity).endpointValue
			} else if identity.type == "literature-cast" {
				KKEndpoint.Cast.literatureCast(identity).endpointValue
			} else if identity.type == "game-cast" {
				KKEndpoint.Cast.gameCast(identity).endpointValue
			} else {
				fatalError("❌ Unsupported cast identity type: \(identity.type)")
			}
		} else if let identity = identity as? SongIdentity {
			KKEndpoint.Songs.details(identity).endpointValue
		} else if let identity = identity as? UserIdentity {
			KKEndpoint.Users.profile(identity).endpointValue
		} else if let identity = identity as? SessionIdentity {
			KKEndpoint.Me.Sessions.details(identity).endpointValue
		} else {
			fatalError("❌ Unsupported identity type: \(type(of: identity.self))")
		}

		let request = KKRequest<I>(
			path: detailsEndpoint,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the details for an array of `KurozoraItem` identities.
	///
	/// - Parameters:
	///    - identities: The array of identities for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: An ``I`` response with the item details.
	func getDetails<I: KurozoraRequestable>(for identities: [KurozoraItem], including relationships: [String] = []) async throws -> I {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !identities.isEmpty {
			parameters["ids"] = identities.map { $0.id.rawValue }.joined(separator: ",")
		}
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let indexEndpoint = if (identities as? [CharacterIdentity]) != nil {
			KKEndpoint.Characters.index.endpointValue
		} else if (identities as? [EpisodeIdentity]) != nil {
			KKEndpoint.Episodes.index.endpointValue
		} else if (identities as? [GameIdentity]) != nil {
			KKEndpoint.Games.index.endpointValue
		} else if (identities as? [LiteratureIdentity]) != nil {
			KKEndpoint.Literatures.index.endpointValue
		} else if (identities as? [PersonIdentity]) != nil {
			KKEndpoint.People.index.endpointValue
		} else if (identities as? [SeasonIdentity]) != nil {
			KKEndpoint.Shows.Seasons.index.endpointValue
		} else if (identities as? [ShowIdentity]) != nil {
			KKEndpoint.Shows.index.endpointValue
		} else if (identities as? [StudioIdentity]) != nil {
			KKEndpoint.Studios.index.endpointValue
		} else if (identities as? [GenreIdentity]) != nil {
			KKEndpoint.Genres.index.endpointValue
		} else if (identities as? [ThemeIdentity]) != nil {
			KKEndpoint.Themes.index.endpointValue
		} else if let identity = (identities as? [CastIdentity])?.first {
			if identity.type == "show-cast" {
				KKEndpoint.Cast.showCastIndex.endpointValue
			} else if identity.type == "literature-cast" {
				KKEndpoint.Cast.literatureCastIndex.endpointValue
			} else if identity.type == "game-cast" {
				KKEndpoint.Cast.gameCastIndex.endpointValue
			} else {
				fatalError("❌ Unsupported cast identity type: \(identity.type)")
			}
		} else if (identities as? [SongIdentity]) != nil {
			KKEndpoint.Songs.index.endpointValue
		} else if (identities as? [UserIdentity]) != nil {
			KKEndpoint.Users.index.endpointValue
		} else if (identities as? [SessionIdentity]) != nil {
			KKEndpoint.Me.Sessions.index.endpointValue
		} else {
			fatalError("❌ Unsupported identity type: \(type(of: identities.self))")
		}

		let request = KKRequest<I>(
			path: indexEndpoint,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the literature details for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``LiteratureResponse`` with the literature details.
	func getDetails(forLiterature literatureIdentity: LiteratureIdentity, including relationships: [String] = []) async throws -> LiteratureResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<LiteratureResponse>(
			path: KKEndpoint.Literatures.details(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the literature details for the given literature identities.
	///
	/// - Parameters:
	///    - literatureIdentities: The identities of the literatures for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``LiteratureResponse`` with the literature details.
	func getDetails(forLiteratures literatureIdentities: [LiteratureIdentity], including relationships: [String] = []) async throws -> LiteratureResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !literatureIdentities.isEmpty {
			parameters["ids"] = literatureIdentities.map { $0.id.rawValue }.joined(separator: ",")
		}
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<LiteratureResponse>(
			path: KKEndpoint.Literatures.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the people for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the people should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``PersonIdentityResponse`` with the people for the literature.
	func getPeople(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> PersonIdentityResponse {
		let request = KKRequest<PersonIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.people(literatureIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the cast for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the cast should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CastIdentityResponse`` with the cast for the literature.
	func getCast(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> CastIdentityResponse {
		let request = KKRequest<CastIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.cast(literatureIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the characters for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the characters should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CharacterIdentityResponse`` with the characters for the literature.
	func getCharacters(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> CharacterIdentityResponse {
		let request = KKRequest<CharacterIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.characters(literatureIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related literatures for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the related literatures should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedLiteratureResponse`` with the related literatures.
	func getRelatedLiteratures(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedLiteratureResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedLiteratureResponse>(
			path: next ?? KKEndpoint.Literatures.relatedLiteratures(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related shows for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the related shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedShowResponse`` with the related shows.
	func getRelatedShows(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedShowResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedShowResponse>(
			path: next ?? KKEndpoint.Literatures.relatedShows(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the related games for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the related games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedGameResponse`` with the related games.
	func getRelatedGames(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedGameResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedGameResponse>(
			path: next ?? KKEndpoint.Literatures.relatedGames(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the literature.
	func getReviews(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Literatures.reviews(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the studios for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the studios should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``StudioIdentityResponse`` with the studios for the literature.
	func getStudios(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> StudioIdentityResponse {
		let request = KKRequest<StudioIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.studios(literatureIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the more by studio section for the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature for which the more by studio section should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the more by studio literatures.
	func getMoreByStudio(forLiterature literatureIdentity: LiteratureIdentity, next: String? = nil, limit: Int = 25) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.moreByStudio(literatureIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the literature with the given literature identity.
	///
	/// - Parameters:
	///    - literatureIdentity: The identity of the literature to rate.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	func rateLiterature(_ literatureIdentity: LiteratureIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Literatures.rate(literatureIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetch the upcoming literatures.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the upcoming literatures.
	func getUpcomingLiteratures(next: String? = nil, limit: Int = 25) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.Literatures.upcoming.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
