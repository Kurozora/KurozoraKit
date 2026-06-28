//
//  WeeklyDigestRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's weekly digest.
public struct WeeklyDigestRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> WeeklyDigest {
		let request = KKRequest<WeeklyDigestResponse>(
			path: KKEndpoint.Me.Digest.index.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		let sections = try await self.context.client.send(request).data
		return WeeklyDigest(sections: sections)
	}
}
