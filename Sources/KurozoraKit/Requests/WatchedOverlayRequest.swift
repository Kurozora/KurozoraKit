//
//  WatchedOverlayRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the watched state for a bounded set of episode IDs.
///
/// ```swift
/// let response = try await kurozoraKit
///     .watchedOverlay(forUser: .me, episodes: episodeIDs)
///     .response()
/// ```
public struct WatchedOverlayRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let episodeIDs: [KurozoraItemID]

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, episodeIDs: [KurozoraItemID]) {
		self.context = context
		self.userIdentity = userIdentity
		self.episodeIDs = episodeIDs
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> WatchedOverlayResponse {
		// An empty id set needs no round-trip.
		guard !self.episodeIDs.isEmpty else { return WatchedOverlayResponse(data: []) }

		return try await self.context.client.send(self.makeRequest())
	}

	/// Executes the request with an `If-None-Match` validator.
	///
	/// - Parameter etag: The entity tag from the previous response.
	///
	/// - Returns: The conditional outcome of the request.
	public func response(ifNoneMatch etag: String?) async throws -> KKConditionalResponse<WatchedOverlayResponse> {
		// An empty id set needs no round-trip.
		guard !self.episodeIDs.isEmpty else { return .modified(WatchedOverlayResponse(data: []), etag: nil) }

		return try await self.context.client.send(self.makeRequest(), ifNoneMatch: etag)
	}

	private func makeRequest() -> KKRequest<WatchedOverlayResponse> {
		let query: [String: Any] = [
			"kind": WatchedKind.episodes.rawValue,
			"ids": self.episodeIDs.map { $0.rawValue }.joined(separator: ","),
		]

		return KKRequest<WatchedOverlayResponse>(
			path: KKEndpoint.Users.watched(self.userIdentity).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: query
		)
	}
}
