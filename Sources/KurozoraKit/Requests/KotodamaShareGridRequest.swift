//
//  KotodamaShareGridRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the share grid of a finished Kotodama game.
public struct KotodamaShareGridRequest: Sendable {
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
	public func response() async throws -> ResourceCollection<KotodamaShareGrid> {
		let request = KKRequest<ResourceCollection<KotodamaShareGrid>>(
			path: KKEndpoint.Minigames.Kotodama.share(self.gameID).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
