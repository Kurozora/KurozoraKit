//
//  KurozoraKit+Notifications.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of notifications for the authenticated user.
	///
	/// - Returns: A ``UserNotificationResponse`` containing the user's notifications.
	public func getNotifications() async throws -> UserNotificationResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<UserNotificationResponse>(
			path: KKEndpoint.Me.Notifications.index.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the notification details for the given notification identity.
	///
	/// - Parameter notificationIdentity: The identity of the notification to fetch details for.
	///
	/// - Returns: A ``UserNotificationResponse`` containing the notification details.
	public func getDetails(forNotification notificationIdentity: KurozoraItem) async throws -> UserNotificationResponse {
		let request = KKRequest<UserNotificationResponse>(
			path: KKEndpoint.Me.Notifications.details(notificationIdentity).endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}

	/// Updates the read status for the given notification.
	///
	/// - Parameters:
	///   - notificationID: The identifier of the notification to update.
	///   - readStatus: The new read status to apply.
	///
	/// - Returns: A ``UserNotificationUpdateResponse`` containing the updated notification state.
	public func updateNotification(_ notificationID: String, withReadStatus readStatus: ReadStatus) async throws -> UserNotificationUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"notification": notificationID,
			"read": readStatus.rawValue
		]

		let request = KKRequest<UserNotificationUpdateResponse>(
			path: KKEndpoint.Me.Notifications.update.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Deletes the notification for the given notification identity.
	///
	/// - Parameter notification: The identity of the notification to delete.
	///
	/// - Returns: A ``KKSuccess`` indicating whether the request succeeded.
	public func deleteNotification(_ notification: KurozoraItem) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Notifications.delete(notification).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
