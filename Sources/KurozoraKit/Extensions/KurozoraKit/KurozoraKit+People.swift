//
//  KurozoraKit+People.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2020.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetch the people index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``PersonIdentityResponse`` with the people index.
	func peopleIndex(next: String? = nil, limit: Int = 5, filter: PersonFilter?) async throws -> PersonIdentityResponse {
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

		let request = KKRequest<PersonIdentityResponse>(
			path: next ?? KKEndpoint.People.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the person details for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///
	/// - Returns: A ``PersonResponse`` with the person details.
	func getDetails(forPerson personIdentity: PersonIdentity, including relationships: [String] = []) async throws -> PersonResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<PersonResponse>(
			path: KKEndpoint.People.details(personIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the characters for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the characters should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``CharacterIdentityResponse`` with the characters for the person.
	func getCharacters(forPerson personIdentity: PersonIdentity, next: String? = nil, limit: Int = 25) async throws -> CharacterIdentityResponse {
		let request = KKRequest<CharacterIdentityResponse>(
			path: next ?? KKEndpoint.People.characters(personIdentity).endpointValue,
			method: .get,
			headers: self.headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the shows for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` with the shows for the person.
	func getShows(forPerson personIdentity: PersonIdentity, next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.People.shows(personIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the literatures for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the literatures should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the literatures for the person.
	func getLiteratures(forPerson personIdentity: PersonIdentity, next: String? = nil, limit: Int = 25) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.People.literatures(personIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the games for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the games for the person.
	func getGames(forPerson personIdentity: PersonIdentity, next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.People.games(personIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the person.
	func getReviews(forPerson personIdentity: PersonIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.People.reviews(personIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the person with the given person identity.
	///
	/// - Parameters:
	///    - personIdentity: The identity of the person to rate.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	func ratePerson(_ personIdentity: PersonIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score,
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.People.rate(personIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}
}
