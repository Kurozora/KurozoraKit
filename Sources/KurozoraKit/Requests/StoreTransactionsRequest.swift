//
//  StoreTransactionsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/05/2026.
//  MIT License
//

import Foundation

/// A request for the user's StoreKit transactions.
public struct StoreTransactionsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> StoreTransactionsResponse {
		let request = KKRequest<StoreTransactionsResponse>(
			path: KKEndpoint.Store.transactions.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
