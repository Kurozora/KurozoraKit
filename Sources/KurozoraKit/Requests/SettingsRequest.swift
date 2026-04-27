//
//  SettingsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the app settings.
public struct SettingsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> SettingsResponse {
		let request = KKRequest<SettingsResponse>(
			path: KKEndpoint.Misc.settings.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
