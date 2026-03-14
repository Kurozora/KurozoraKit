//
//  KurozoraKit+Store.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2020.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Verifies the authenticated user's transaction receipt.
	///
	/// - Parameter receipt: The Base64-encoded receipt data.
	///
	/// - Returns: A ``ReceiptResponse`` with the verified receipt.
	public func verifyReceipt(_ receipt: String) async throws -> ReceiptResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<ReceiptResponse>(
			path: KKEndpoint.Store.verify.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(["receipt": receipt])
		)

		let receiptResponse = try await self.client.send(request)
		if let receipt = receiptResponse.data.first {
			User.current?.attributes.updateSubscription(from: receipt)
		}
		return receiptResponse
	}
}
