//
//  UpdateFeedMessageRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that updates a feed message.
public struct UpdateFeedMessageRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let update: FeedMessageUpdateRequest

	// MARK: - Initializers
	internal init(context: RequestContext, update: FeedMessageUpdateRequest) {
		self.context = context
		self.update = update
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> FeedMessageUpdateResponse {
		let parameters: [String: Any] = [
			"content": self.update.content,
			"is_nsfw": self.update.isNSFW,
			"is_spoiler": self.update.isSpoiler
		]

		let request = KKRequest<FeedMessageUpdateResponse>(
			path: KKEndpoint.Feed.Messages.update(self.update.feedMessageIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
