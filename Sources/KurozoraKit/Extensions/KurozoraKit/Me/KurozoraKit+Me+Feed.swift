//
//  KurozoraKit+Me+Feed.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 07/09/2020.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the authenticated user's feed messages.
	///
	/// - Parameters:
	///   - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///   - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FeedMessageResponse`` containing the feed messages.
	public func getFeedMessages(next: String? = nil, limit: Int = 25) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: next ?? KKEndpoint.Me.Feed.messages.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}
}
