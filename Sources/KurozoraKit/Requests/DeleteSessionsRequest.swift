//
//  DeleteSessionsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/06/2026.
//  MIT License
//

import Foundation

/// A request that deletes multiple, or all, of the authenticated user's sessions.
public struct DeleteSessionsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let identities: [SessionIdentity]
	private let deleteAll: Bool
	private let password: String

	// MARK: - Initializers
	internal init(context: RequestContext, identities: [SessionIdentity], password: String) {
		self.context = context
		self.identities = identities
		self.deleteAll = false
		self.password = password
	}

	internal init(context: RequestContext, deleteAll: Bool, password: String) {
		self.context = context
		self.identities = []
		self.deleteAll = deleteAll
		self.password = password
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let parameters: [String: Any] = [
			"identities": self.deleteAll ? "all" : self.identities.map { $0.id.rawValue }.joined(separator: ","),
			"password": self.password
		]

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Sessions.deleteMultiple.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
