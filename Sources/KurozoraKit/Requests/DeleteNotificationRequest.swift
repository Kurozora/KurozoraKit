//
//  DeleteNotificationRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes a notification.
public struct DeleteNotificationRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let identity: any KurozoraItem

	// MARK: - Initializers
	internal init(context: RequestContext, identity: any KurozoraItem) {
		self.context = context
		self.identity = identity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Notifications.delete(self.identity).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
