//
//  UserReviewsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the reviews written by a given user.
public struct UserReviewsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private var _kind: ReviewKind?
	private var _hasReview: Bool?
	private var _rating: Double?
	private var _sortType: ReviewSortType?
	private var _sortOption: ReviewSortOption?
	private var _cursor: PageCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity) {
		self.context = context
		self.userIdentity = userIdentity
		self._kind = nil
		self._hasReview = nil
		self._rating = nil
		self._sortType = nil
		self._sortOption = nil
		self._cursor = nil
		self._limit = 25
	}

	// MARK: - Modifiers
	/// Limits the results to reviews of the given kind.
	public func kind(_ kind: ReviewKind?) -> Self {
		var copy = self
		copy._kind = kind
		return copy
	}

	/// Limits the results to ratings with or without a written review.
	public func hasReview(_ hasReview: Bool?) -> Self {
		var copy = self
		copy._hasReview = hasReview
		return copy
	}

	/// Limits the results to ratings shown as the given number of stars.
	public func rating(_ rating: Double?) -> Self {
		var copy = self
		copy._rating = rating
		return copy
	}

	/// Sorts the results by the given type and direction.
	public func sorted(by sortType: ReviewSortType?, _ option: ReviewSortOption?) -> Self {
		var copy = self
		copy._sortType = sortType
		copy._sortOption = option
		return copy
	}

	/// Sets the pagination cursor for fetching the next page.
	public func cursor(_ cursor: PageCursor?) -> Self {
		var copy = self
		copy._cursor = cursor
		return copy
	}

	/// Sets the maximum number of items to return per page.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<Review> {
		var query: [String: Any] = [
			"limit": self._limit
		]
		if let kind = self._kind {
			query["kind"] = kind.rawValue
		}
		if let hasReview = self._hasReview {
			query["has_review"] = hasReview
		}
		if let rating = self._rating {
			query["rating"] = rating
		}

		if let sortType = self._sortType, let sortOption = self._sortOption {
			query["sort"] = "\(sortType.parameterValue)\(sortOption.parameterValue)"
		}

		let request = KKRequest<ResourceCollection<Review>>(
			path: self._cursor?.urlString ?? KKEndpoint.Users.reviews(self.userIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: query
		)
		return try await self.context.client.send(request)
	}
}
