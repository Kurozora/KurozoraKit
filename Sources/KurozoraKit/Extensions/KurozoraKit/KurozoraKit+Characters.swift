//
//  KurozoraKit+Characters.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/06/2020.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetch the characters index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``CharacterIdentityResponse`` with the characters index.
	func charactersIndex(next: String? = nil, limit: Int = 5, filter: CharacterFilter?) async throws -> CharacterIdentityResponse {
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

		let request = KKRequest<CharacterIdentityResponse>(
			path: next ?? KKEndpoint.Characters.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the character details for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object of the character for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``CharacterResponse`` with the character details.
	func getDetails(forCharacter characterIdentity: CharacterIdentity, including relationships: [String] = []) async throws -> CharacterResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<CharacterResponse>(
			path: KKEndpoint.Characters.details(characterIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the people for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object for which the people should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``PersonIdentityResponse`` with the people for the character.
	func getPeople(forCharacter characterIdentity: CharacterIdentity, next: String? = nil, limit: Int = 25) async throws -> PersonIdentityResponse {
		let request = KKRequest<PersonIdentityResponse>(
			path: next ?? KKEndpoint.Characters.people(characterIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the shows for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object for which the shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` with the shows for the character.
	func getShows(forCharacter characterIdentity: CharacterIdentity, next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Characters.shows(characterIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the literatures for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object for which the literatures should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the literatures for the character.
	func getLiteratures(forCharacter characterIdentity: CharacterIdentity, next: String? = nil, limit: Int = 25) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.Characters.literatures(characterIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the games for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object for which the games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the games for the character.
	func getGames(forCharacter characterIdentity: CharacterIdentity, next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Characters.games(characterIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The character identity object for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the character.
	func getReviews(forCharacter characterIdentity: CharacterIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Characters.reviews(characterIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the character with the given character identity.
	///
	/// - Parameters:
	///    - characterIdentity: The id of the character which should be rated.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	func rateCharacter(_ characterIdentity: CharacterIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score,
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Characters.rate(characterIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Delete the authenticated user's rating of the specified character.
	///
	/// - Parameters:
	///    - characterIdentity: The id of the character whose rating should be deleted.
	///
	/// - Returns: A ``KKSuccess`` with the delete rating response.
	func deleteRating(_ characterIdentity: CharacterIdentity) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Characters.deleteRating(characterIdentity).endpointValue,
			method: .delete,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
