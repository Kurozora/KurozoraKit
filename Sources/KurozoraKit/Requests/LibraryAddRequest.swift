//
//  LibraryAddRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that adds one or more items to the authenticated user's library.
///
/// ```swift
/// let response = try await kurozoraKit
///     .addToLibrary(.shows, status: .watching, itemIDs: [show.id])
///     .response()
/// ```
public struct LibraryAddRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let status: LibraryStatus
	private let itemIDs: [KurozoraItemID]

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, status: LibraryStatus, itemIDs: [KurozoraItemID]) {
		self.context = context
		self.kind = kind
		self.status = status
		self.itemIDs = itemIDs
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibraryUpdateResponse {
		precondition(!self.itemIDs.isEmpty, "LibraryAddRequest requires at least one itemID.")

		let chunks = self.itemIDs.chunked(by: 25)
		var iterator = chunks.makeIterator()

		guard let firstChunk = iterator.next() else {
			fatalError("Unreachable — itemIDs is non-empty.")
		}

		var lastResponse = try await self.send(chunk: firstChunk)
		while let chunk = iterator.next() {
			lastResponse = try await self.send(chunk: chunk)
		}
		return lastResponse
	}

	private func send(chunk: [KurozoraItemID]) async throws -> LibraryUpdateResponse {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_ids": chunk.map { $0.rawValue },
			"status": self.status.rawValue,
		]

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.index.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
