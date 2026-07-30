//
//  SubmitKotodamaGuessRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that submits a guess against a Kotodama game.
public struct SubmitKotodamaGuessRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let gameID: KurozoraItemID
	private let guess: String

	// MARK: - Initializers
	internal init(context: RequestContext, gameID: KurozoraItemID, guess: String) {
		self.context = context
		self.gameID = gameID
		self.guess = guess
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.guess(self.gameID).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(["guess": self.guess.lowercased()])
		)
		return try await self.context.client.send(request)
	}
}
