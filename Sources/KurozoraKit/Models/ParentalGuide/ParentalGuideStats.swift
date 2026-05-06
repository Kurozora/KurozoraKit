//
//  ParentalGuideStats.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores per-category aggregate statistics for a media's parental guide.
public struct ParentalGuideStats: Codable, Sendable {
	// MARK: - Properties
	/// The per-category aggregate stats in ``ParentalGuideCategory`` order.
	public let categories: [CategoryStats]
}

extension ParentalGuideStats {
	/// A root object that stores aggregate statistics for a single parental guide category.
	public struct CategoryStats: Codable, Sendable {
		// MARK: - Properties

		/// The weighted-trimmed-mean rating for the category.
		public let averageRating: ParentalGuideRating

		/// The average frequency for the category, if any submissions specified one.
		public let averageFrequency: ParentalGuideFrequency?

		/// The average depiction for the category, if any submissions specified one.
		public let averageDepiction: ParentalGuideDepiction?

		/// The distribution of severity ratings.
		public let ratingDistribution: RatingDistribution

		/// The total number of submissions in this category.
		public let totalCount: Int

		/// The number of submissions that match the average rating bucket.
		public let matchingCount: Int
	}

	/// A root object that stores the bucket counts for severity ratings.
	public struct RatingDistribution: Codable, Sendable {
		// MARK: - Properties
		/// The number of `none` ratings.
		public let none: Int

		/// The number of `mild` ratings.
		public let mild: Int

		/// The number of `moderate` ratings.
		public let moderate: Int

		/// The number of `severe` ratings.
		public let severe: Int
	}
}
