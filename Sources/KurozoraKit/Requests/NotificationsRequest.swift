//
//  NotificationsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's notifications.
public struct NotificationsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<UserNotification> {
		let request = KKRequest<ResourceCollection<UserNotification>>(
			path: KKEndpoint.Me.Notifications.index.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
