//
//  VerifyReceiptRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that verifies a transaction receipt.
public struct VerifyReceiptRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let receipt: String

	// MARK: - Initializers
	internal init(context: RequestContext, receipt: String) {
		self.context = context
		self.receipt = receipt
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<Receipt> {
		let request = KKRequest<ResourceCollection<Receipt>>(
			path: KKEndpoint.Store.verify.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(["receipt": self.receipt])
		)
		return try await self.context.client.send(request)
	}
}
