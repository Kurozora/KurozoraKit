//
//  JoinKotodamaVersusRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that joins a Kotodama versus game by seed.
public struct JoinKotodamaVersusRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let seed: String

	// MARK: - Initializers
	internal init(context: RequestContext, seed: String) {
		self.context = context
		self.seed = seed
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.joinVersus(self.seed).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
