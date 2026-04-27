//
//  PinFeedMessageRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that pins or unpins a feed message.
public struct PinFeedMessageRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let messageIdentity: FeedMessageIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, messageIdentity: FeedMessageIdentity) {
		self.context = context
		self.messageIdentity = messageIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> FeedMessageUpdateResponse {
		let request = KKRequest<FeedMessageUpdateResponse>(
			path: KKEndpoint.Feed.Messages.pin(self.messageIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
