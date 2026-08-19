//
//  VoteOnReviewRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

/// A request that toggles helpful vote on a review.
public struct VoteOnReviewRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let reviewIdentity: ReviewIdentity
	private let vote: ReviewVote?

	// MARK: - Initializers
	internal init(context: RequestContext, reviewIdentity: ReviewIdentity, vote: ReviewVote?) {
		self.context = context
		self.reviewIdentity = reviewIdentity
		self.vote = vote
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ReviewVoteUpdateResponse {
		var body: [String: Any] = [:]

		if let vote = self.vote {
			body["vote"] = vote.rawValue
		}

		let request = KKRequest<ReviewVoteUpdateResponse>(
			path: KKEndpoint.Reviews.vote(self.reviewIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: body.isEmpty ? .none : .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
