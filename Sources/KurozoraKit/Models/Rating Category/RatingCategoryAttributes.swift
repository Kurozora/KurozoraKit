//
//  RatingCategoryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

extension RatingCategory {
	/// A root object that stores information about a single rating category, such as the category's name, weight, and the authenticated user's score.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The slug of the rating category.
		public let slug: String

		/// The name of the rating category.
		public let name: String

		/// The description of what the rating category covers.
		public let description: String?

		/// The weight of the rating category in the overall rating.
		public let weight: Double

		/// The position of the rating category among its siblings.
		public let displayOrder: Int

		/// The authenticated user's score for the rating category.
		public var score: Double?

		/// The authenticated user's review of the rating category.
		public var review: String?
	}
}

// MARK: - Constants
extension RatingCategory.Attributes {
	/// The lowest score a rating category accepts.
	public static let minimumScore: Double = 0.0

	/// The highest score a rating category accepts.
	public static let maximumScore: Double = 10.0
}
