//
//  VerifyTransactionsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/04/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a transactions verification request.
public struct VerifyTransactionsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let transactions: [String]

	// MARK: - Initializers
	internal init(context: RequestContext, transactions: [String]) {
		self.context = context
		self.transactions = transactions
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ReceiptResponse {
		let request = KKRequest<ReceiptResponse>(
			path: KKEndpoint.Store.verify.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(["transactions": self.transactions])
		)
		return try await self.context.client.send(request)
	}
}
