//
//  DeleteRatingRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/07/2026.
//  MIT License
//

import Foundation

/// A request that deletes the authenticated user's rating for a resource.
public struct DeleteRatingRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String) {
		self.context = context
		self.endpoint = endpoint
	}

	// MARK: - Execution
	/// Executes the request and returns the identity of the deleted review.
	///
	/// The collection is empty when the user had no rating to delete.
	public func response() async throws -> ResourceCollection<ReviewIdentity> {
		let request = KKRequest<ResourceCollection<ReviewIdentity>>(
			path: self.endpoint,
			method: .delete,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
