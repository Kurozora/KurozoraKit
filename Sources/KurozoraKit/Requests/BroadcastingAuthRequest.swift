//
//  BroadcastingAuthRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 15/05/2026.
//  MIT License
//

import Foundation

/// A request that signs a private-channel subscription for the authenticated user.
public struct BroadcastingAuthRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let socketID: String

	// MARK: - Initializers
	internal init(context: RequestContext, socketID: String) {
		self.context = context
		self.socketID = socketID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> BroadcastingAuthResponse {
		let parameters: [String: Any] = [
			"socket_id": self.socketID,
			"channel_name": "private-self"
		]

		let request = KKRequest<BroadcastingAuthResponse>(
			path: KKEndpoint.Broadcasting.auth.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
