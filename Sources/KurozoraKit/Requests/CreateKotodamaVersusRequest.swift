//
//  CreateKotodamaVersusRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that creates a Kotodama versus game with a shareable seed.
public struct CreateKotodamaVersusRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _wordID: KurozoraItemID?

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
		self._wordID = nil
	}

	// MARK: - Modifiers
	/// Sets the word the versus game is played with.
	///
	/// - Parameter wordID: The id of the word to play.
	///
	/// - Returns: A copy of the request with the word applied.
	public func word(_ wordID: KurozoraItemID?) -> Self {
		var copy = self
		copy._wordID = wordID
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		var body: [String: Any] = [:]
		if let wordID = self._wordID {
			body["wordID"] = wordID.rawValue
		}

		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.createVersus.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: body.isEmpty ? .none : .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
