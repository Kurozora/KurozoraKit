//
//  PostFeedMessageRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that posts a new feed message.
public struct PostFeedMessageRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let message: FeedMessageRequest

	// MARK: - Initializers
	internal init(context: RequestContext, message: FeedMessageRequest) {
		self.context = context
		self.message = message
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<FeedMessage> {
		var parameters: [String: Any] = [
			"content": self.message.content,
			"is_nsfw": self.message.isNSFW,
			"is_spoiler": self.message.isSpoiler
		]
		if let messageID = self.message.parentIdentity?.id {
			parameters["parent_id"] = messageID
			parameters["is_reply"] = self.message.isReply
			parameters["is_reshare"] = self.message.isReShare
		}

		let request = KKRequest<ResourceCollection<FeedMessage>>(
			path: KKEndpoint.Feed.post.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
