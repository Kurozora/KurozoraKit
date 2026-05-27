//
//  IssueTimeoutRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// A request that issues a moderation timeout against a user.
public struct IssueTimeoutRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let userIdentity: UserIdentity
	private let duration: TimeoutDuration
	private let reason: TimeoutReason
	private let note: String?

	// MARK: - Initializers
	internal init(context: RequestContext, userIdentity: UserIdentity, duration: TimeoutDuration, reason: TimeoutReason, note: String?) {
		self.context = context
		self.userIdentity = userIdentity
		self.duration = duration
		self.reason = reason
		self.note = note
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> UserTimeoutResponse {
		var body: [String: Any] = [
			"duration": self.duration.rawValue,
			"reason_key": self.reason.rawValue,
		]

		if let note = self.note, !note.isEmpty {
			body["note"] = note
		}

		let request = KKRequest<UserTimeoutResponse>(
			path: KKEndpoint.Users.timeout(self.userIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)

		return try await self.context.client.send(request)
	}
}
