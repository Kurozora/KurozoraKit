//
//  UpdateNotificationRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that updates the read status of a notification.
public struct UpdateNotificationRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let notificationID: String
	private let readStatus: ReadStatus

	// MARK: - Initializers
	internal init(context: RequestContext, notificationID: String, readStatus: ReadStatus) {
		self.context = context
		self.notificationID = notificationID
		self.readStatus = readStatus
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> UserNotificationUpdateResponse {
		let parameters: [String: Any] = [
			"notification": self.notificationID,
			"read": self.readStatus.rawValue
		]

		let request = KKRequest<UserNotificationUpdateResponse>(
			path: KKEndpoint.Me.Notifications.update.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
