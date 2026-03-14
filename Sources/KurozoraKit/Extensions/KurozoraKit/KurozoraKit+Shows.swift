//
//  KurozoraKit+Show.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the paginated shows index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 100.
	///    - filter: An optional filter to apply to the results.
	///
	/// - Returns: A ``ShowIdentityResponse`` containing the matching show identities.
	public func showsIndex(next: String? = nil, limit: Int = 5, filter: ShowFilter?) async throws -> ShowIdentityResponse {
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

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Shows.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the details for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show to retrieve.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``ShowResponse`` containing the show's details.
	public func getDetails(forShow showIdentity: ShowIdentity, including relationships: [String] = []) async throws -> ShowResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<ShowResponse>(
			path: KKEndpoint.Shows.details(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the details for the given show identities.
	///
	/// - Parameters:
	///    - showIdentities: The identities of the shows to retrieve.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``ShowResponse`` containing the requested shows.
	public func getDetails(forShows showIdentities: [ShowIdentity], including relationships: [String] = []) async throws -> ShowResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !showIdentities.isEmpty {
			parameters["ids"] = showIdentities.map { $0.id.rawValue }.joined(separator: ",")
		}
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<ShowResponse>(
			path: KKEndpoint.Shows.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the people associated with the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``PersonIdentityResponse`` containing the associated person identities.
	public func getPeople(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> PersonIdentityResponse {
		let request = KKRequest<PersonIdentityResponse>(
			path: next ?? KKEndpoint.Shows.people(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the cast for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CastIdentityResponse`` containing the cast identities.
	public func getCast(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> CastIdentityResponse {
		let request = KKRequest<CastIdentityResponse>(
			path: next ?? KKEndpoint.Shows.cast(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the characters for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CharacterIdentityResponse`` containing the character identities.
	public func getCharacters(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> CharacterIdentityResponse {
		let request = KKRequest<CharacterIdentityResponse>(
			path: next ?? KKEndpoint.Shows.characters(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the related shows for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedShowResponse`` containing the related shows.
	public func getRelatedShows(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedShowResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedShowResponse>(
			path: next ?? KKEndpoint.Shows.relatedShows(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the related literatures for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedLiteratureResponse`` containing the related literatures.
	public func getRelatedLiteratures(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedLiteratureResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedLiteratureResponse>(
			path: next ?? KKEndpoint.Shows.relatedLiteratures(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the related games for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``RelatedGameResponse`` containing the related games.
	public func getRelatedGames(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> RelatedGameResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<RelatedGameResponse>(
			path: next ?? KKEndpoint.Shows.relatedGames(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the reviews for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` containing the show's reviews.
	public func getReviews(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Shows.reviews(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the seasons for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - reversed: Whether to reverse the order of the results.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``SeasonIdentityResponse`` containing the season identities.
	public func getSeasons(forShow showIdentity: ShowIdentity, reversed: Bool = false, next: String? = nil, limit: Int = 25) async throws -> SeasonIdentityResponse {
		let parameters: [String: Any] = [
			"limit": limit,
			"reversed": reversed
		]

		let request = KKRequest<SeasonIdentityResponse>(
			path: next ?? KKEndpoint.Shows.seasons(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the songs for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowSongResponse`` containing the show's songs.
	public func getSongs(forShow showIdentity: ShowIdentity, limit: Int = 25) async throws -> ShowSongResponse {
		let request = KKRequest<ShowSongResponse>(
			path: KKEndpoint.Shows.songs(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the studios for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``StudioIdentityResponse`` containing the studio identities.
	public func getStudios(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> StudioIdentityResponse {
		let request = KKRequest<StudioIdentityResponse>(
			path: next ?? KKEndpoint.Shows.studios(showIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches additional shows from the same studio as the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` containing the show identities from the same studio.
	public func getMoreByStudio(forShow showIdentity: ShowIdentity, next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Shows.moreByStudio(showIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Submits a rating for the given show.
	///
	/// - Parameters:
	///    - showIdentity: The identity of the show to rate.
	///    - score: The rating score to submit.
	///    - description: An optional review description to include with the rating.
	///
	/// - Returns: A ``KKSuccess`` indicating the rating was submitted.
	public func rateShow(_ showIdentity: ShowIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Shows.rate(showIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetches the upcoming shows.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` containing the upcoming show identities.
	public func getUpcomingShows(next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Shows.upcoming.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
