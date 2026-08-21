//
//  RateRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that submits a rating for a resource.
///
/// Create a `RateRequest` through typed ``KurozoraKit`` factory methods
/// like ``KurozoraKit/rate(_:score:)-show`` and call ``response()`` to execute.
///
/// ```swift
/// _ = try await kurozoraKit
///     .rate(showIdentity, score: 4.5)
///     .description("Great show!")
///     .response()
/// ```
public struct RateRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String
	private let score: Double
	private var _description: String?
	private var _isSpoiler: Bool?
	private var _recommendation: ReviewRecommendation?
	private var _ratingCategories: [RatingCategory]

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, score: Double) {
		self.context = context
		self.endpoint = endpoint
		self.score = score
		self._description = nil
		self._isSpoiler = nil
		self._recommendation = nil
		self._ratingCategories = []
	}

	// MARK: - Modifiers
	/// Adds a review description to the rating.
	public func description(_ text: String?) -> Self {
		var copy = self
		copy._description = text
		return copy
	}

	/// Sets whether the review contains a spoiler.
	///
	/// - Parameter isSpoiler: Whether the review contains a spoiler.
	public func isSpoiler(_ isSpoiler: Bool) -> Self {
		var copy = self
		copy._isSpoiler = isSpoiler
		return copy
	}

	/// Sets the reviewer's recommendation.
	///
	/// - Parameter recommendation: The recommendation to submit.
	public func recommendation(_ recommendation: ReviewRecommendation) -> Self {
		var copy = self
		copy._recommendation = recommendation
		return copy
	}

	/// Adds the scored rating categories of a detailed rating.
	///
	/// - Parameter ratingCategories: The rating categories to submit.
	public func categoryScores(_ ratingCategories: [RatingCategory]) -> Self {
		var copy = self
		copy._ratingCategories = ratingCategories.filter { $0.attributes.score != nil }
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the identity of the submitted review.
	///
	/// The collection is empty when the submission cleared the rating instead of storing one.
	public func response() async throws -> ResourceCollection<ReviewIdentity> {
		var body: [String: Any] = [:]
		if let description = self._description {
			body["description"] = description
		}
		if let isSpoiler = self._isSpoiler {
			body["isSpoiler"] = isSpoiler ? 1 : 0
		}
		if let recommendation = self._recommendation {
			body["recommendation"] = recommendation.rawValue
		}

		if self._ratingCategories.isEmpty {
			body["rating"] = self.score
		} else {
			var categoryScores: [String: Double] = [:]
			var categoryReviews: [String: String] = [:]

			for ratingCategory in self._ratingCategories {
				guard let score = ratingCategory.attributes.score else { continue }

				categoryScores[ratingCategory.id.rawValue] = score

				if let review = ratingCategory.attributes.review, !review.isEmpty {
					categoryReviews[ratingCategory.id.rawValue] = review
				}
			}

			body["categoryScores"] = categoryScores

			if !categoryReviews.isEmpty {
				body["categoryReviews"] = categoryReviews
			}
		}

		let request = KKRequest<ResourceCollection<ReviewIdentity>>(
			path: self.endpoint,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
