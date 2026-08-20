//
//  SetNoteRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/08/2026.
//  MIT License
//

import Foundation

/// A request that writes the authenticated user's note on an item.
///
/// ```swift
/// let response = try await kurozoraKit
///     .setNote(on: show.id, kind: .shows, body: "Rewatch after the movie.")
///     .response()
/// ```
public struct SetNoteRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: ReviewKind
	private let itemID: KurozoraItemID
	private let body: String?

	// MARK: - Initializers
	internal init(context: RequestContext, kind: ReviewKind, itemID: KurozoraItemID, body: String?) {
		self.context = context
		self.kind = kind
		self.itemID = itemID
		self.body = body
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> NoteUpdateResponse {
		let request = KKRequest<NoteUpdateResponse>(
			path: KKEndpoint.Me.notes.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded([
				"kind": self.kind.rawValue,
				"model_id": self.itemID.rawValue,
				"body": self.body ?? "",
			])
		)
		return try await self.context.client.send(request)
	}
}
