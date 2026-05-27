//
//  UpdateTimeoutAppealRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/05/2026.
//  MIT License
//

import Foundation

/// A request that updates the authenticated user's existing timeout appeal.
public struct UpdateTimeoutAppealRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let message: String

	// MARK: - Initializers
	internal init(context: RequestContext, message: String) {
		self.context = context
		self.message = message
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> UserTimeoutResponse {
		let body: [String: Any] = [
			"message": self.message,
		]

		let request = KKRequest<UserTimeoutResponse>(
			path: KKEndpoint.Me.timeoutAppealUpdate.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)

		return try await self.context.client.send(request)
	}
}
