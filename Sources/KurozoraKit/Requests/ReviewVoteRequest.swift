//
//  ReviewVoteRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

/// The set of available review vote actions.
public enum ReviewVote: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Mark the review as helpful.
	case helpful

	/// Mark the review as unhelpful.
	case unhelpful
}

/// A root object that stores information about a review vote payload.
public struct ReviewVoteRequest: Sendable {
	// MARK: - Properties
	/// The vote to cast, or `nil` to clear the existing vote.
	public let vote: ReviewVote?

	// MARK: - Initializers
	/// Initialize a new instance of `ReviewVoteRequest`.
	///
	/// - Parameter vote: The vote to cast, or `nil` to clear the existing vote.
	public init(vote: ReviewVote?) {
		self.vote = vote
	}
}
