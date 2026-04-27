//
//  ClearLibraryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that clears all items from the authenticated user's library.
public struct ClearLibraryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind
	private let password: String

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind, password: String) {
		self.context = context
		self.kind = kind
		self.password = password
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let parameters: [String: Any] = [
			"library": self.kind.rawValue,
			"password": self.password
		]

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Library.clear.endpointValue,
			method: .delete,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
