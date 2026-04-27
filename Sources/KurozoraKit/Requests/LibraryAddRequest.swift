//
//  LibraryAddRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that adds an item to the authenticated user's library.
///
/// ```swift
/// let response = try await kurozoraKit
///     .addToLibrary(.shows, status: .watching, itemID: show.id)
///     .response()
/// ```
public struct LibraryAddRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let status: LibraryStatus
	private let itemID: KurozoraItemID

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, status: LibraryStatus, itemID: KurozoraItemID) {
		self.context = context
		self.kind = kind
		self.status = status
		self.itemID = itemID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> LibraryUpdateResponse {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_id": self.itemID,
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
