//
//  LibraryUpdateRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A request that updates a library entry for the authenticated user.
///
/// ```swift
/// let response = try await kurozoraKit
///     .updateInLibrary(.shows, itemID: show.id)
///     .rewatchCount(3)
///     .hidden(true)
///     .response()
/// ```
public struct LibraryUpdateRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let itemID: KurozoraItemID
	private var _rewatchCount: Int?
	private var _isHidden: Bool?

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, itemID: KurozoraItemID) {
		self.context = context
		self.kind = kind
		self.itemID = itemID
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
		var parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"model_id": self.itemID,
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
