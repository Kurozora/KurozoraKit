//
//  KurozoraKit+Studio.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/06/2020.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetch the studios index.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the index list.
	///
	/// - Returns: A ``StudioIdentityResponse`` with the studios index.
	public func studiosIndex(next: String? = nil, limit: Int = 5, filter: StudioFilter?) async throws -> StudioIdentityResponse {
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

		let request = KKRequest<StudioIdentityResponse>(
			path: next ?? KKEndpoint.Studios.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the studio details for the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio for which the details should be fetched.
	///    - relationships: The relationships to include in the response.
	///    - limit: The limit on the number of objects in the specified relationship that are returned.
	///
	/// - Returns: A ``StudioResponse`` with the studio details.
	public func getDetails(forStudio studioIdentity: StudioIdentity, including relationships: [String] = [], limit: Int? = nil) async throws -> StudioResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if !relationships.isEmpty {
			parameters["include"] = relationships.joined(separator: ",")
		}

		let request = KKRequest<StudioResponse>(
			path: KKEndpoint.Studios.details(studioIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetch the shows for the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio for which the shows should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ShowIdentityResponse`` with the shows for the studio.
	public func getShows(forStudio studioIdentity: StudioIdentity, next: String? = nil, limit: Int = 25) async throws -> ShowIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ShowIdentityResponse>(
			path: next ?? KKEndpoint.Studios.shows(studioIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the literatures for the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio for which the literatures should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LiteratureIdentityResponse`` with the literatures for the studio.
	public func getLiteratures(forStudio studioIdentity: StudioIdentity, next: String? = nil, limit: Int = 25) async throws -> LiteratureIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<LiteratureIdentityResponse>(
			path: next ?? KKEndpoint.Studios.literatures(studioIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the games for the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio for which the games should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``GameIdentityResponse`` with the games for the studio.
	public func getGames(forStudio studioIdentity: StudioIdentity, next: String? = nil, limit: Int = 25) async throws -> GameIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GameIdentityResponse>(
			path: next ?? KKEndpoint.Studios.games(studioIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetch the reviews for the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio for which the reviews should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` with the reviews for the studio.
	public func getReviews(forStudio studioIdentity: StudioIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Studios.reviews(studioIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Rate the studio with the given studio identity.
	///
	/// - Parameters:
	///    - studioIdentity: The identity of the studio to rate.
	///    - score: The rating to leave.
	///    - description: The description of the rating.
	///
	/// - Returns: A ``KKSuccess`` with the rating response.
	public func rateStudio(_ studioIdentity: StudioIdentity, with score: Double, description: String?) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"rating": score
		]
		if let description = description {
			parameters["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Studios.rate(studioIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}
}
