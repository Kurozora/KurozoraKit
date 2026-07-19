//
//  LibrarySyncRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's library delta since a given cursor.
///
/// ```swift
/// let response = try await kurozoraKit
///     .librarySync(.shows)
///     .since(cachedCursor)
///     .response()
/// ```
public struct LibrarySyncRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private var _since: SyncCursor?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind) {
		self.context = context
		self.kind = kind
		self._since = nil
		self._limit = 10000
	}

	// MARK: - Modifiers
	/// Sets the resume cursor returned by the previous sync batch.
	public func since(_ cursor: SyncCursor?) -> Self {
		var copy = self
		copy._since = cursor
		return copy
	}

	/// Sets the maximum number of rows the server should return in this batch.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibrarySyncResponse {
		var parameters: [String: Any] = [
			"kind": self.kind.rawValue,
			"limit": self._limit,
		]
		if let since = self._since {
			// `updatedAt` is opaque — echo the server's microsecond timestamp verbatim.
			parameters["since[updated_at]"] = since.updatedAt
			parameters["since[id]"] = since.id
			if let syncedAt = since.syncedAt {
				parameters["since[synced_at]"] = syncedAt
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
