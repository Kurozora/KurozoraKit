//
//  KurozoraKit+Schedule.swift
//  Pods
//
//  Created by Khoren Katklian on 23/11/2024.
//

import TRON

extension KurozoraKit {
	/// Fetch the schedule for the specified type and date.
	///
	/// - Parameters:
	///    - type: The type of the schedule.
	///    - date: The date for which the schedule is fetched.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get recap list response.
	public func getSchedule(for type: KKScheduleType, in date: Date) -> RequestSender<RecapResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare parameters
		var parameters: [String: Any] = [
			"type": type.rawValue,
			"date": date.formatted(.dateTime.day().month().year())
		]

		// Prepare request
		let recapIndex = KKEndpoint.Me.Recap.index.endpointValue
		let request: APIRequest<RecapResponse, KKAPIError> = tron.codable.request(recapIndex)
			.method(.get)
			.parameters(parameters)
			.headers(headers)

		// Send request
		return request.sender()
	}
}
