//
//  KurozoraKit+Images.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 07/04/2024.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches a collection of random images.
	///
	/// - Parameters:
	///    - kind: The kind of images to fetch.
	///    - collection: The collection the images belong to.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 1 and the maximum value is 25.
	///
	/// - Returns: A ``MediaResponse`` with the random images.
	public func getRandomImages(of kind: MediaKind, from collection: MediaCollection, limit: Int = 1) async throws -> MediaResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let parameters: [String: Any] = [
			"type": kind.rawValue,
			"collection": collection.rawValue,
			"limit": limit
		]

		let request = KKRequest<MediaResponse>(
			path: KKEndpoint.Images.random.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}
}
