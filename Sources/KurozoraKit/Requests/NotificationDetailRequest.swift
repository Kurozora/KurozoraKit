//
//  NotificationDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for a given notification.
public struct NotificationDetailRequest: Sendable {
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
	public func response() async throws -> ResourceCollection<UserNotification> {
		let request = KKRequest<ResourceCollection<UserNotification>>(
			path: KKEndpoint.Me.Notifications.details(self.identity).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
