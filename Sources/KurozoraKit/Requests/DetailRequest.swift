//
//  DetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for a single resource.
///
/// Create a `DetailRequest` through the ``KurozoraKit`` factory method
/// ``KurozoraKit/detail(_:)`` and call ``response()`` to execute.
///
/// ```swift
/// let showResponse = try await kurozoraKit
///     .detail(showIdentity, including: [.cast, .seasons])
///     .response()
/// ```
public struct DetailRequest<T: Fetchable>: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let identity: T
	private var relationships: [String]
	private var embedded: Bool

	// MARK: - Initializers
	internal init(context: RequestContext, identity: T, relationships: [String] = [], embedded: Bool = true) {
		self.context = context
		self.identity = identity
		self.relationships = relationships
		self.embedded = embedded
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

	/// Opts into the cacheable catalog variant by setting `?embedded=0`.
	///
	/// - Parameter embedded: Whether the response should include embedded per-user state.
	///
	/// - Returns: A copy of the request with the embedded flag applied.
	public func embedded(_ embedded: Bool) -> Self {
		var copy = self
		copy.embedded = embedded
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> T.Response {
		var query: [String: Any] = [:]
		if !self.relationships.isEmpty {
			query["include"] = self.relationships.joined(separator: ",")
		}
		if !self.embedded {
			query["embedded"] = "0"
		}

		let request = KKRequest<T.Response>(
			path: self.identity.detailEndpoint,
			method: .get,
			headers: self.context.headers,
			query: query.isEmpty ? nil : query
		)
		return try await self.context.client.send(request)
	}
}
