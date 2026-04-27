//
//  RecapsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the list of available recaps.
public struct RecapsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<Recap> {
		let request = KKRequest<ResourceCollection<Recap>>(
			path: KKEndpoint.Me.Recap.index.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
