//
//  RecapDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the recap for a specific year and month.
public struct RecapDetailRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let year: String
	private let month: String

	// MARK: - Initializers
	internal init(context: RequestContext, year: String, month: String) {
		self.context = context
		self.year = year
		self.month = month
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<RecapItem> {
		let request = KKRequest<ResourceCollection<RecapItem>>(
			path: KKEndpoint.Me.Recap.details(self.year, self.month).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
