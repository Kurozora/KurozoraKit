//
//  ParentalGuideVoteRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

/// The set of available parental guide entry vote actions.
public enum ParentalGuideVote: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Mark the entry as helpful.
	case helpful

	/// Mark the entry as unhelpful.
	case unhelpful
}

/// A root object that stores information about a parental guide entry vote payload.
public struct ParentalGuideVoteRequest: Sendable {
	// MARK: - Properties
	/// The vote to cast, or `nil` to clear the existing vote.
	public let vote: ParentalGuideVote?

	// MARK: - Initializers
	/// Initialize a new instance of `ParentalGuideVoteRequest`.
	///
	/// - Parameter vote: The vote to cast, or `nil` to clear the existing vote.
	public init(vote: ParentalGuideVote?) {
		self.vote = vote
	}
}
