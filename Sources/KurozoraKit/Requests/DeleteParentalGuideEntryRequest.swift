//
//  DeleteParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A request that deletes a parental guide entry.
public struct DeleteParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let entryIdentity: ParentalGuideEntryIdentity

	// MARK: - Initializers
	internal init(context: RequestContext, entryIdentity: ParentalGuideEntryIdentity) {
		self.context = context
		self.entryIdentity = entryIdentity
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.ParentalGuide.deleteEntry(self.entryIdentity).endpointValue,
			method: .delete,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
