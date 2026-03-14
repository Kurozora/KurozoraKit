//
//  KurozoraKit+Reminder.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetches the list of reminders for the authenticated user.
	///
	/// - Parameters:
	///   - libraryKind: The kind of library to fetch reminders from.
	///   - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///   - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReminderLibraryResponse`` containing the reminder library entries.
	func getReminders(for libraryKind: KKLibrary.Kind, next: String? = nil, limit: Int = 25) async throws -> ReminderLibraryResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"limit": limit,
		]

		let request = KKRequest<ReminderLibraryResponse>(
			path: next ?? KKEndpoint.Me.Reminders.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Updates the reminder status of a model in the authenticated user's library.
	///
	/// - Parameters:
	///   - libraryKind: The kind of library the model belongs to.
	///   - modelID: The identifier of the model to update.
	///
	/// - Returns: A ``ReminderResponse`` containing the updated reminder status.
	func updateReminderStatus(inLibrary libraryKind: KKLibrary.Kind, modelID: KurozoraItemID) async throws -> ReminderResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"model_id": modelID,
		]

		let request = KKRequest<ReminderResponse>(
			path: KKEndpoint.Me.Reminders.update.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// The reminder subscription URL for the authenticated user.
	var reminderSubscriptionURL: URL {
		let path = KKEndpoint.Me.Reminders.download.endpointValue
		let base = self.apiEndpoint.baseURL
		return URL(string: path, relativeTo: URL(string: base))?.absoluteURL
			?? URL(string: base + path)
			?? URL(fileURLWithPath: "")
	}
}
