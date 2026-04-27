//
//  LibraryRemoveRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that removes an item from the authenticated user's library.
///
/// ```swift
/// let response = try await kurozoraKit
///     .removeFromLibrary(.shows, itemID: show.id)
///     .response()
/// ```
public struct LibraryRemoveRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let itemID: KurozoraItemID

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, itemID: KurozoraItemID) {
		self.context = context
		self.kind = kind
		self.itemID = itemID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibraryUpdateResponse {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_id": self.itemID,
		]

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.delete.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
