//
//  DeleteReviewRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes a review.
public struct DeleteReviewRequest: Sendable {
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
			path: KKEndpoint.Reviews.delete(self.reviewIdentity).endpointValue,
			method: .delete,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
