//
//  FetchParentalGuideRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A request that fetches the parental guide stats and entries for a media item.
public struct FetchParentalGuideRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let endpoint: String

	// MARK: - Initializers
	internal init(context: RequestContext, endpoint: String) {
		self.context = context
		self.endpoint = endpoint
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ParentalGuideResponse {
		let request = KKRequest<ParentalGuideResponse>(
			path: self.endpoint,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
