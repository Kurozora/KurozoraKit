//
//  KurozoraKit+Schedule.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/11/2024.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the schedule for the specified type and date.
	///
	/// - Parameters:
	///    - type: The type of the schedule.
	///    - date: The date for which to fetch the schedule.
	///
	/// - Returns: A ``ScheduleResponse`` with the schedule for the given type and date.
	public func getSchedule(for type: KKScheduleType, in date: Date) async throws -> ScheduleResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"

		let parameters: [String: Any] = [
			"type": type.rawValue,
			"date": dateFormatter.string(from: date)
		]

		let request = KKRequest<ScheduleResponse>(
			path: KKEndpoint.Schedule.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}
}
