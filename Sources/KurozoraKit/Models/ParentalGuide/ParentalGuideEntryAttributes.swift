//
//  ParentalGuideEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

extension ParentalGuideEntry {
	/// A root object that stores information about a single parental guide entry, such as the entry's category, rating, and reason.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The category of the entry.
		public let category: ParentalGuideCategory

		/// The severity rating of the entry.
		public let rating: ParentalGuideRating

		/// The frequency of the content described in the entry.
		public let frequency: ParentalGuideFrequency?

		/// The depiction of the content described in the entry.
		public let depiction: ParentalGuideDepiction?

		/// The user-provided reason describing the content.
		public let reason: String?

		/// Whether the entry's reason contains spoiler material.
		public var isSpoiler: Bool

		/// The number of helpful votes the entry has received.
		public var helpfulCount: Int

		/// The number of unhelpful votes the entry has received.
		public var unhelpfulCount: Int

		/// Whether the authenticated user has marked the entry as helpful.
		public var isHelpful: Bool?

		/// The authenticated user's helpfulness state on the entry.
		fileprivate var _helpfulness: ParentalGuideHelpfulness?

		/// The id of the user that authored the entry.
		public let userID: String
	}
}

// MARK: - Helpers
extension ParentalGuideEntry.Attributes {
	// MARK: - Properties
	/// The authenticated user's helpfulness state on the entry.
	public var helpfulness: ParentalGuideHelpfulness {
		get {
			return self._helpfulness ?? ParentalGuideHelpfulness(self.isHelpful)
		}
		set {
			self._helpfulness = newValue
		}
	}

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
		self.helpfulness = ParentalGuideHelpfulness(newHelpfulness)
	}
}
