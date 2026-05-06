//
//  SubmitParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A request that upserts the authenticated user's parental guide entry on a media item.
public struct SubmitParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String
	private let payload: ParentalGuideEntryRequest

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String, payload: ParentalGuideEntryRequest) {
		self.context = context
		self.endpoint = endpoint
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
			path: self.endpoint,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
