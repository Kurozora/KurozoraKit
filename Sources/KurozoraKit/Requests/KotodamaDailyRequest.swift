//
//  KotodamaDailyRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches today's Kotodama puzzle and the authenticated user's game for it.
public struct KotodamaDailyRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.daily.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
