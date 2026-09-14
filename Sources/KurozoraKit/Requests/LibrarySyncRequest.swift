//
//  LibrarySyncRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's library delta since the given cursors.
public struct LibrarySyncRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _cursors: [LibrarySyncStream: SyncCursor]
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
		self._cursors = [:]
		self._limit = 10000
	}

	// MARK: - Modifiers
	/// Sets the resume cursors returned by the previous sync round.
	public func since(_ cursors: [LibrarySyncStream: SyncCursor]) -> Self {
		var copy = self
		copy._cursors = cursors
		return copy
	}

	/// Sets the maximum number of rows the server should return per stream.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibrarySyncResponse {
		var parameters: [String: Any] = ["limit": self._limit]

		for (stream, cursor) in self._cursors {
			// `updatedAt` is opaque and echoed back verbatim.
			parameters["since[\(stream.rawValue)][updated_at]"] = cursor.updatedAt
			parameters["since[\(stream.rawValue)][id]"] = cursor.id

			if let syncedAt = cursor.syncedAt {
				parameters["since[\(stream.rawValue)][synced_at]"] = syncedAt
			}
		}

		let request = KKRequest<LibrarySyncResponse>(
			path: KKEndpoint.Me.Library.sync.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
