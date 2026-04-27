//
//  FeedMessageDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for a given feed message.
public struct FeedMessageDetailRequest: Sendable {
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
	public func response() async throws -> ResourceCollection<FeedMessage> {
		let request = KKRequest<ResourceCollection<FeedMessage>>(
			path: KKEndpoint.Feed.Messages.details(self.messageIdentity).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
