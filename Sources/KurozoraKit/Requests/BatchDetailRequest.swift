//
//  BatchDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for multiple resources by ID.
///
/// Create a `BatchDetailRequest` through the ``KurozoraKit`` factory method
/// ``KurozoraKit/details(_:)`` and call ``response()`` to execute.
///
/// ```swift
/// let shows = try await kurozoraKit
///     .details(showIdentities)
///     .response()
/// ```
public struct BatchDetailRequest<T: Fetchable>: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let identities: [T]
	private var relationships: [String]

	// MARK: - Initializers
	internal init(context: RequestContext, identities: [T], relationships: [String] = []) {
		self.context = context
		self.identities = identities
		self.relationships = relationships
	}

	// MARK: - Modifiers
	/// Sideloads the given relationships in the response.
	///
	/// - Parameter relationships: The relationship keys to include.
	///
	/// - Returns: A copy of the request with the relationships applied.
	public func including(_ relationships: [String]) -> Self {
		var copy = self
		copy.relationships = relationships
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> T.Response {
		var query: [String: Any] = [:]
		if !self.identities.isEmpty {
			query["ids"] = self.identities.map { $0.id.rawValue }.joined(separator: ",")
		}
		if !self.relationships.isEmpty {
			query["include"] = self.relationships.joined(separator: ",")
		}

		let request = KKRequest<T.Response>(
			path: self.identities.first?.indexEndpoint ?? "",
			method: .get,
			headers: self.context.headers,
			query: query.isEmpty ? nil : query
		)
		return try await self.context.client.send(request)
	}
}
