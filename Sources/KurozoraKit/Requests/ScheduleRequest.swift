//
//  ScheduleRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the schedule for a given type and date.
public struct ScheduleRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let type: KKScheduleType
	private let date: Date

	// MARK: - Initializers
	internal init(context: RequestContext, type: KKScheduleType, date: Date) {
		self.context = context
		self.type = type
		self.date = date
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<Schedule> {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"

		let parameters: [String: Any] = [
			"type": self.type.rawValue,
			"date": dateFormatter.string(from: self.date)
		]

		let request = KKRequest<ResourceCollection<Schedule>>(
			path: KKEndpoint.Schedule.index.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
