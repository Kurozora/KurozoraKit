//
//  KurozoraKit+Genre.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of genres.
	///
	/// - Returns: A ``GenreResponse`` with the list of genres.
	public func getGenres() async throws -> GenreResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GenreResponse>(
			path: KKEndpoint.Genres.index.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the genre details for the given genre identity.
	///
	/// - Parameter genreIdentity: The identity of the genre to fetch.
	///
	/// - Returns: A ``GenreResponse`` with the genre details.
	public func getDetails(forGenre genreIdentity: GenreIdentity) async throws -> GenreResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<GenreResponse>(
			path: KKEndpoint.Genres.details(genreIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
