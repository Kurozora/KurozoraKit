//
//  DeleteAccountRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes the authenticated user's account.
public struct DeleteAccountRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let password: String

	// MARK: - Initializers
	internal init(context: RequestContext, password: String) {
		self.context = context
		self.password = password
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	@MainActor
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.delete.endpointValue,
			method: .delete,
			headers: self.context.headers,
			query: ["password": self.password]
		)
		let response = try await self.context.client.send(request)
		self.context.applySignOut()
		return response
	}
}
