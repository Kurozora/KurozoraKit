//
//  LibraryUpdateRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that updates one or more library entries for the authenticated user.
///
/// ```swift
/// let response = try await kurozoraKit
///     .updateInLibrary(.shows, itemIDs: [show.id])
///     .rewatchCount(3)
///     .hidden(true)
///     .response()
/// ```
public struct LibraryUpdateRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let itemIDs: [KurozoraItemID]
	private var _rewatchCount: Int?
	private var _isHidden: Bool?

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, itemIDs: [KurozoraItemID]) {
		self.context = context
		self.kind = kind
		self.itemIDs = itemIDs
		self._rewatchCount = nil
		self._isHidden = nil
	}

	// MARK: - Modifiers
	/// Sets the rewatch count for the library entry.
	public func rewatchCount(_ count: Int?) -> Self {
		var copy = self
		copy._rewatchCount = count
		return copy
	}

	/// Sets whether the library entry is hidden from public view.
	public func hidden(_ isHidden: Bool?) -> Self {
		var copy = self
		copy._isHidden = isHidden
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibraryUpdateResponse {
		precondition(!self.itemIDs.isEmpty, "LibraryUpdateRequest requires at least one itemID.")

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
		var parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_ids": chunk.map { $0.rawValue },
		]
		if let rewatchCount = self._rewatchCount {
			parameters["rewatch_count"] = rewatchCount
		}
		if let isHidden = self._isHidden {
			parameters["is_hidden"] = isHidden
		}

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.update.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
