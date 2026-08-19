//
//  ReportReviewRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

import Foundation

/// A request that files a report against a review.
public struct ReportReviewRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let reviewIdentity: ReviewIdentity
	private let reason: ReportReason
	private let details: String?

	// MARK: - Initializers
	internal init(context: RequestContext, reviewIdentity: ReviewIdentity, reason: ReportReason, details: String?) {
		self.context = context
		self.reviewIdentity = reviewIdentity
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
			path: KKEndpoint.Reviews.report(self.reviewIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)

		return try await self.context.client.send(request)
	}
}
