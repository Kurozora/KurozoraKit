//
//  KurozoraKit+Explore.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/08/2020.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the explore page content, optionally filtered by genre or theme.
	///
	/// Passing `nil` for both `genreID` and `themeID` returns the global explore page.
	///
	/// - Parameters:
	///    - genreID: The identifier of a genre to filter the explore page by.
	///    - themeID: The identifier of a theme to filter the explore page by.
	///
	/// - Returns: An ``ExploreCategoryResponse`` with the explore categories.
	public func getExplore(genreID: KurozoraItemID? = nil, themeID: KurozoraItemID? = nil) async throws -> ExploreCategoryResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [:]
		if let genreID = genreID {
			parameters["genre_id"] = genreID
		}
		if let themeID = themeID {
			parameters["theme_id"] = themeID
		}

		let request = KKRequest<ExploreCategoryResponse>(
			path: KKEndpoint.Explore.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the content of an explore category.
	///
	/// - Parameters:
	///    - exploreCategoryIdentity: The identity of the explore category to fetch.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///
	/// - Returns: An ``ExploreCategoryResponse`` with the explore category details.
	public func getExplore(_ exploreCategoryIdentity: ExploreCategoryIdentity, next: String? = nil, limit: Int = 5) async throws -> ExploreCategoryResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ExploreCategoryResponse>(
			path: next ?? KKEndpoint.Explore.details(exploreCategoryIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
