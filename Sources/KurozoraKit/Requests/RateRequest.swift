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

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, score: Double) {
		self.context = context
		self.endpoint = endpoint
		self.score = score
		self._description = nil
	}

	// MARK: - Modifiers
	/// Adds a review description to the rating.
	public func description(_ text: String?) -> Self {
		var copy = self
		copy._description = text
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		var body: [String: Any] = ["rating": self.score]
		if let description = self._description {
			body["description"] = description
		}

		let request = KKRequest<KKSuccess>(
			path: self.endpoint,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
