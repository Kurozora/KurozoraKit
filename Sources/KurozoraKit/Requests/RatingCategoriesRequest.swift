//
//  RatingCategoriesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches the rating categories of a review kind.
///
/// Create a `RatingCategoriesRequest` through ``KurozoraKit/ratingCategories(for:)``
/// and call ``response()`` to execute.
///
/// ```swift
/// let categories = try await kurozoraKit
///     .ratingCategories(for: .shows)
///     .scores(of: show.id)
///     .response()
/// ```
public struct RatingCategoriesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: ReviewKind
	private var _modelID: String?

	// MARK: - Initializers
	internal init(context: RequestContext, kind: ReviewKind) {
		self.context = context
		self.kind = kind
		self._modelID = nil
	}

	// MARK: - Modifiers
	/// Includes the authenticated user's scores for the given resource.
	///
	/// - Parameter modelID: The identifier of the rated resource.
	public func scores(of modelID: KurozoraItemID) -> Self {
		var copy = self
		copy._modelID = modelID.rawValue
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> RatingCategoryResponse {
		var parameters: [String: Any] = [
			"kind": self.kind.rawValue
		]

		if let modelID = self._modelID {
			parameters["id"] = modelID
		}

		let request = KKRequest<RatingCategoryResponse>(
			path: KKEndpoint.Reviews.categories.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
