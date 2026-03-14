//
//  KurozoraKit+Feed.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches a list of feed messages for the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose feed messages to fetch.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FeedMessageResponse`` with the list of user feed messages.
	public func getFeedMessages(forUser userIdentity: UserIdentity, next: String? = nil, limit: Int = 25) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: next ?? KKEndpoint.Users.feedMessages(userIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches a list of home feed messages.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FeedMessageResponse`` with the list of home feed messages.
	public func getFeedHome(next: String? = nil, limit: Int = 25) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: next ?? KKEndpoint.Feed.home.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches a list of explore feed messages.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FeedMessageResponse`` with the list of explore feed messages.
	public func getFeedExplore(next: String? = nil, limit: Int = 25) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: next ?? KKEndpoint.Feed.explore.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Posts a new message to the feed.
	///
	/// If the message is a reply or a re-share, supply the parent message's ID.
	///
	/// - Parameter feedMessageRequest: An instance of `FeedMessageRequest` containing the new feed message details.
	///
	/// - Returns: A ``FeedMessageResponse`` with the posted feed message.
	public func postFeedMessage(_ feedMessageRequest: FeedMessageRequest) async throws -> FeedMessageResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"content": feedMessageRequest.content,
			"is_nsfw": feedMessageRequest.isNSFW,
			"is_spoiler": feedMessageRequest.isSpoiler
		]
		if let messageID = feedMessageRequest.parentIdentity?.id {
			parameters["parent_id"] = messageID
			parameters["is_reply"] = feedMessageRequest.isReply
			parameters["is_reshare"] = feedMessageRequest.isReShare
		}

		let request = KKRequest<FeedMessageResponse>(
			path: KKEndpoint.Feed.post.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Fetches the details of the given feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message to fetch.
	///
	/// - Returns: A ``FeedMessageResponse`` with the feed message details.
	public func getDetails(forFeedMessage messageIdentity: FeedMessageIdentity) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: KKEndpoint.Feed.Messages.details(messageIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the replies for the given feed message.
	///
	/// - Parameters:
	///    - messageIdentity: The identity of the feed message whose replies to fetch.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FeedMessageResponse`` with the feed message replies.
	public func getReplies(forFeedMessage messageIdentity: FeedMessageIdentity, next: String? = nil, limit: Int = 25) async throws -> FeedMessageResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FeedMessageResponse>(
			path: next ?? KKEndpoint.Feed.Messages.replies(messageIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Updates the details for the given feed message.
	///
	/// - Parameter feedMessageUpdateRequest: An instance of `FeedMessageUpdateRequest` containing the updated feed message details.
	///
	/// - Returns: A ``FeedMessageUpdateResponse`` with the updated feed message.
	public func updateMessage(_ feedMessageUpdateRequest: FeedMessageUpdateRequest) async throws -> FeedMessageUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"content": feedMessageUpdateRequest.content,
			"is_nsfw": feedMessageUpdateRequest.isNSFW,
			"is_spoiler": feedMessageUpdateRequest.isSpoiler
		]

		let request = KKRequest<FeedMessageUpdateResponse>(
			path: KKEndpoint.Feed.Messages.update(feedMessageUpdateRequest.feedMessageIdentity).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Hearts or un-hearts a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message to heart or un-heart.
	///
	/// - Returns: A ``FeedMessageUpdateResponse`` with the updated feed message.
	public func heartMessage(_ messageIdentity: FeedMessageIdentity) async throws -> FeedMessageUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<FeedMessageUpdateResponse>(
			path: KKEndpoint.Feed.Messages.heart(messageIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Pins or unpins a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message to pin or unpin.
	///
	/// - Returns: A ``FeedMessageUpdateResponse`` with the updated feed message.
	public func pinMessage(_ messageIdentity: FeedMessageIdentity) async throws -> FeedMessageUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<FeedMessageUpdateResponse>(
			path: KKEndpoint.Feed.Messages.pin(messageIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Deletes the specified feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message to delete.
	///
	/// - Returns: A ``KKSuccess`` indicating whether the deletion succeeded.
	public func deleteMessage(_ messageIdentity: FeedMessageIdentity) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Feed.Messages.delete(messageIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
