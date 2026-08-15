//
//  MeSettingsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's settings.
public struct MeSettingsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> MeSettingsResponse {
		let request = KKRequest<MeSettingsResponse>(
			path: KKEndpoint.Me.settings.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
