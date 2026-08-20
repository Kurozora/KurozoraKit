//
//  ReviewRevisionsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches the superseded versions of a review.
///
/// Create a `ReviewRevisionsRequest` through ``KurozoraKit/revisions(for:)``
/// and call ``response()`` to execute.
///
/// ```swift
/// let revisions = try await kurozoraKit
///     .revisions(for: reviewIdentity)
///     .response()
/// ```
public struct ReviewRevisionsRequest: Sendable {
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
	public func response() async throws -> ResourceCollection<ReviewRevision> {
		let request = KKRequest<ResourceCollection<ReviewRevision>>(
			path: KKEndpoint.Reviews.revisions(self.reviewIdentity).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
