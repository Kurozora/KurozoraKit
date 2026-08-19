//
//  ReviewAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/07/2023.
//  MIT License
//

import Foundation

extension Review {
	/// A root object that stores information about a single review, such as the review's score, and description.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The score of the review.
		public let score: Double

		/// The description of the review.
		public let description: String?

		/// The private note of the review belonging stores the current user.
		public let note: String?

		/// Whether the review contains a spoiler.
		public let isSpoiler: Bool

		/// The reviewer's recommendation.
		public let recommendation: ReviewRecommendation?

		/// The reviewer's progress through the item when the review was written.
		public let progress: Int?

		/// The item's total number of parts.
		public let progressTotal: Int?

		/// Whether the review reads as a meme, art, or a one-word joke.
		public let isLowEffort: Bool

		/// Whether the staff elevated the review to Editor's Choice.
		public let isElevated: Bool

		/// The number of helpful votes the review has received.
		public var helpfulCount: Int

		/// The number of unhelpful votes the review has received.
		public var unhelpfulCount: Int

		/// Whether the authenticated user has marked the review as helpful.
		public var isHelpful: Bool?

		/// The creation date of the review.
		public let createdAt: Date
	}
}

// MARK: - Helpers
extension Review.Attributes {
	// MARK: - Functions
	/// Applies a vote, updating the helpful and unhelpful counts.
	///
	/// - Parameter newHelpfulness: The new helpfulness state, or `nil` when the user has no active vote.
	public mutating func applyVote(_ newHelpfulness: Bool?) {
		let oldHelpfulness = self.isHelpful

		if oldHelpfulness == newHelpfulness {
			return
		}

		if let oldHelpfulness = oldHelpfulness {
			if oldHelpfulness {
				self.helpfulCount = max(0, self.helpfulCount - 1)
			} else {
				self.unhelpfulCount = max(0, self.unhelpfulCount - 1)
			}
		}

		if let newHelpfulness = newHelpfulness {
			if newHelpfulness {
				self.helpfulCount += 1
			} else {
				self.unhelpfulCount += 1
			}
		}

		self.isHelpful = newHelpfulness
	}
}
