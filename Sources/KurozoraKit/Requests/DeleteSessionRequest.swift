//
//  DeleteSessionRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes the specified session from the user's active sessions.
public struct DeleteSessionRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let sessionIdentity: SessionIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, sessionIdentity: SessionIdentity) {
		self.context = context
		self.sessionIdentity = sessionIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Sessions.delete(self.sessionIdentity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
