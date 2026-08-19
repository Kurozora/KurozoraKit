//
//  ReportFeedMessageRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

import Foundation

/// A request that files a report against a feed message.
public struct ReportFeedMessageRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let messageIdentity: FeedMessageIdentity
	private let reason: ReportReason
	private let details: String?

	// MARK: - Initializers
	internal init(context: RequestContext, messageIdentity: FeedMessageIdentity, reason: ReportReason, details: String?) {
		self.context = context
		self.messageIdentity = messageIdentity
		self.reason = reason
		self.details = details
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		var body: [String: Any] = ["reason_key": self.reason.rawValue]

		if let details = self.details, !details.isEmpty {
			body["details"] = details
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Feed.Messages.report(self.messageIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)

		return try await self.context.client.send(request)
	}
}
