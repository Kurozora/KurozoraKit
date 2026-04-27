//
//  ProfileDetailsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the authenticated user's profile details.
public struct ProfileDetailsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	@MainActor
	public func response() async throws -> ResourceCollection<User> {
		let request = KKRequest<ResourceCollection<User>>(
			path: KKEndpoint.Me.profile.endpointValue,
			method: .get,
			headers: self.context.headers
		)
		let response = try await self.context.client.send(request)
		self.context.applyProfile(response.data.first)
		return response
	}
}
