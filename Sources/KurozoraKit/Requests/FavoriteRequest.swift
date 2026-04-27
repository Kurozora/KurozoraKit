//
//  FavoriteRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that toggles the favorite status for a library item.
///
/// ```swift
/// let response = try await kurozoraKit
///     .toggleFavorite(inLibrary: .shows, itemID: show.id)
///     .response()
/// ```
public struct FavoriteRequest: Sendable {
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
	public func response() async throws -> FavoriteResponse {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_id": self.itemID,
		]

		let request = KKRequest<FavoriteResponse>(
			path: KKEndpoint.Me.Favorites.update.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
