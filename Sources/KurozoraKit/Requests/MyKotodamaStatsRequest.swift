//
//  MyKotodamaStatsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's Kotodama stats.
public struct MyKotodamaStatsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaUserStats> {
		let request = KKRequest<ResourceCollection<KotodamaUserStats>>(
			path: KKEndpoint.Minigames.Kotodama.myStats.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
