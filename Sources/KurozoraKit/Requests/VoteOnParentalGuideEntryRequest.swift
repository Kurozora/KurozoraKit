//
//  VoteOnParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A request that toggles helpful vote on a parental guide entry.
public struct VoteOnParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let entryIdentity: ParentalGuideEntryIdentity
	private let vote: ParentalGuideVote?

	// MARK: - Initializers
	internal init(context: RequestContext, entryIdentity: ParentalGuideEntryIdentity, vote: ParentalGuideVote?) {
		self.context = context
		self.entryIdentity = entryIdentity
		self.vote = vote
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ParentalGuideVoteUpdateResponse {
		var body: [String: Any] = [:]

		if let vote = self.vote {
			body["vote"] = vote.rawValue
		}

		let request = KKRequest<ParentalGuideVoteUpdateResponse>(
			path: KKEndpoint.ParentalGuide.voteEntry(self.entryIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: body.isEmpty ? .none : .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
