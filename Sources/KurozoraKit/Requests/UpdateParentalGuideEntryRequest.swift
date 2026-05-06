//
//  UpdateParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 08/05/2026.
//  MIT License
//

import Foundation

/// A request that updates the authenticated user's parental guide entry in place.
public struct UpdateParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let entryIdentity: ParentalGuideEntryIdentity
	private let payload: ParentalGuideEntryRequest

	// MARK: - Initializers
	internal init(context: RequestContext, entryIdentity: ParentalGuideEntryIdentity, payload: ParentalGuideEntryRequest) {
		self.context = context
		self.entryIdentity = entryIdentity
		self.payload = payload
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ParentalGuideEntryResponse {
		var body: [String: Any] = [
			"category": self.payload.category.rawValue,
			"rating": self.payload.rating.rawValue,
			"is_spoiler": self.payload.isSpoiler ? 1 : 0,
		]

		if let frequency = self.payload.frequency {
			body["frequency"] = frequency.rawValue
		}

		if let depiction = self.payload.depiction {
			body["depiction"] = depiction.rawValue
		}

		if let reason = self.payload.reason, !reason.isEmpty {
			body["reason"] = reason
		}

		let request = KKRequest<ParentalGuideEntryResponse>(
			path: KKEndpoint.ParentalGuide.updateEntry(self.entryIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
