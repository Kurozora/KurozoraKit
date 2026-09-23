//
//  RecapStatsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

/// A request that fetches the habit and activity stats of a recap period.
public struct RecapStatsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let year: String
	private let month: String

	// MARK: - Initializers
	internal init(context: RequestContext, year: String, month: String) {
		self.context = context
		self.year = year
		self.month = month
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<RecapStat> {
		let request = KKRequest<ResourceCollection<RecapStat>>(
			path: KKEndpoint.Me.Recap.stats(self.year, self.month).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
