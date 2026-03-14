//
//  KurozoraKit+Recap.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 04/01/2024.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of available recaps.
	///
	/// - Returns: A ``RecapResponse`` with the recap list.
	public func getRecaps() async throws -> RecapResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<RecapResponse>(
			path: KKEndpoint.Me.Recap.index.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the recap for the specified year and month.
	///
	/// - Parameters:
	///    - year: The year for which to fetch the recap.
	///    - month: The month for which to fetch the recap.
	///
	/// - Returns: A ``RecapItemResponse`` with the recap item details.
	public func getRecap(for year: String, month: String) async throws -> RecapItemResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<RecapItemResponse>(
			path: KKEndpoint.Me.Recap.details(year, month).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
