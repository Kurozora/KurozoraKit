//
//  DeleteAccessTokensRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/06/2026.
//  MIT License
//

import Foundation

/// A request that deletes multiple, or all, of the authenticated user's access tokens.
public struct DeleteAccessTokensRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let accessTokens: [AccessToken]
	private let deleteAll: Bool
	private let password: String

	// MARK: - Initializers
	internal init(context: RequestContext, accessTokens: [AccessToken], password: String) {
		self.context = context
		self.accessTokens = accessTokens
		self.deleteAll = false
		self.password = password
	}

	internal init(context: RequestContext, deleteAll: Bool, password: String) {
		self.context = context
		self.accessTokens = []
		self.deleteAll = deleteAll
		self.password = password
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let parameters: [String: Any] = [
			"identities": self.deleteAll ? "all" : self.accessTokens.map { $0.id.rawValue }.joined(separator: ","),
			"password": self.password
		]

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.deleteMultiple.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
