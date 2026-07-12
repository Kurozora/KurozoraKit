//
//  ReviewsOverlayRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the review state for a bounded set of model IDs.
///
/// ```swift
/// let response = try await kurozoraKit
///     .reviewsOverlay(forUser: .me, kind: .shows, itemIDs: showIDs)
///     .response()
/// ```
public struct ReviewsOverlayRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let kind: ReviewKind
	private let itemIDs: [KurozoraItemID]

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, kind: ReviewKind, itemIDs: [KurozoraItemID]) {
		self.context = context
		self.userIdentity = userIdentity
		self.kind = kind
		self.itemIDs = itemIDs
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ReviewsOverlayResponse {
		// An empty id set needs no round-trip.
		guard !self.itemIDs.isEmpty else { return ReviewsOverlayResponse(data: []) }

		return try await self.context.client.send(self.makeRequest())
	}

	/// Executes the request with an `If-None-Match` validator.
	///
	/// - Parameter etag: The entity tag from the previous response.
	///
	/// - Returns: The conditional outcome of the request.
	public func response(ifNoneMatch etag: String?) async throws -> KKConditionalResponse<ReviewsOverlayResponse> {
		// An empty id set needs no round-trip.
		guard !self.itemIDs.isEmpty else { return .modified(ReviewsOverlayResponse(data: []), etag: nil) }

		return try await self.context.client.send(self.makeRequest(), ifNoneMatch: etag)
	}

	private func makeRequest() -> KKRequest<ReviewsOverlayResponse> {
		let query: [String: Any] = [
			"kind": self.kind.rawValue,
			"ids": self.itemIDs.map { $0.rawValue }.joined(separator: ","),
		]

		return KKRequest<ReviewsOverlayResponse>(
			path: KKEndpoint.Users.reviews(self.userIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: query
		)
	}
}
