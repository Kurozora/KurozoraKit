//
//  ElevateReviewRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

/// A request that toggles a review's Editor's Choice slot.
public struct ElevateReviewRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let reviewIdentity: ReviewIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, reviewIdentity: ReviewIdentity) {
		self.context = context
		self.reviewIdentity = reviewIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Reviews.elevate(self.reviewIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
