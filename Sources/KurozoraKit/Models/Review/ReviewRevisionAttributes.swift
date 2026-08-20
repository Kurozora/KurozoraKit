//
//  ReviewRevisionAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

import Foundation

extension ReviewRevision {
	/// A root object that stores information about a single review revision, such as the revision's score, and description.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The score of the revision.
		public let score: Double

		/// The description of the revision.
		public let description: String

		/// Whether the revision contains a spoiler.
		public let isSpoiler: Bool

		/// The reviewer's recommendation.
		public let recommendation: ReviewRecommendation?

		/// The reviewer's progress through the item when the revision was written.
		public let progress: Int?

		/// The item's total number of parts.
		public let progressTotal: Int?

		/// The date the revision was written.
		public let writtenAt: Date
	}
}
