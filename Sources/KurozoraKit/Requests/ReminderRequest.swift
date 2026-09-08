//
//  ReminderRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that updates the reminder status of one or more library items.
///
/// ```swift
/// let response = try await kurozoraKit
///     .toggleReminder(inLibrary: .shows, itemIDs: [show.id])
///     .response()
/// ```
public struct ReminderRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let itemIDs: [KurozoraItemID]
	private var _isReminded: Bool?

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, itemIDs: [KurozoraItemID]) {
		self.context = context
		self.kind = kind
		self.itemIDs = itemIDs
		self._isReminded = nil
	}

	// MARK: - Modifiers
	/// Sets the requested reminder state.
	public func reminded(_ isReminded: Bool?) -> Self {
		var copy = self
		copy._isReminded = isReminded
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ReminderResponse {
		precondition(!self.itemIDs.isEmpty, "ReminderRequest requires at least one itemID.")

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

	private func send(chunk: [KurozoraItemID]) async throws -> ReminderResponse {
		var parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_ids": chunk.map { $0.rawValue },
		]
		if let isReminded = self._isReminded {
			parameters["is_reminded"] = isReminded
		}

		let request = KKRequest<ReminderResponse>(
			path: KKEndpoint.Me.Reminders.update.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
