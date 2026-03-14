//
//  KurozoraKit+Me+Favorite.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the favorites list for the authenticated user.
	///
	/// - Parameters:
	///   - libraryKind: The kind of library to fetch favorites from.
	///   - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///   - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FavoriteLibraryResponse`` containing the favorite library entries.
	public func getFavorites(from libraryKind: KKLibrary.Kind, next: String? = nil, limit: Int = 25) async throws -> FavoriteLibraryResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"limit": limit
		]

		let request = KKRequest<FavoriteLibraryResponse>(
			path: next ?? KKEndpoint.Me.Favorites.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Updates the favorite status of a model in the authenticated user's library.
	///
	/// - Parameters:
	///   - libraryKind: The kind of library the model belongs to.
	///   - modelID: The identifier of the model to update.
	///
	/// - Returns: A ``FavoriteResponse`` containing the updated favorite status.
	public func updateFavoriteStatus(inLibrary libraryKind: KKLibrary.Kind, modelID: KurozoraItemID) async throws -> FavoriteResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"model_id": modelID,
		]

		let request = KKRequest<FavoriteResponse>(
			path: KKEndpoint.Me.Favorites.update.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}
}
