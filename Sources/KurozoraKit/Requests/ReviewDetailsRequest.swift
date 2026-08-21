//
//  ReviewDetailsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches a single review.
///
/// Create a `ReviewDetailsRequest` through ``KurozoraKit/review(_:)``
/// and call ``response()`` to execute.
///
/// ```swift
/// let review = try await kurozoraKit
///     .review(reviewIdentity)
///     .response()
///     .data
///     .first
/// ```
public struct ReviewDetailsRequest: Sendable {
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
	public func response() async throws -> ResourceCollection<Review> {
		let request = KKRequest<ResourceCollection<Review>>(
			path: KKEndpoint.Reviews.details(self.reviewIdentity).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
