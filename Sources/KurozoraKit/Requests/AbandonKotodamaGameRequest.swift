//
//  AbandonKotodamaGameRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that abandons an in-progress Kotodama game.
public struct AbandonKotodamaGameRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let gameID: KurozoraItemID

	// MARK: - Initializers
	internal init(context: RequestContext, gameID: KurozoraItemID) {
		self.context = context
		self.gameID = gameID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.abandon(self.gameID).endpointValue,
			method: .post,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
