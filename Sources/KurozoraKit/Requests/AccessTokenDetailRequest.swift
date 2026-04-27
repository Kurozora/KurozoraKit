//
//  AccessTokenDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for a given access token.
public struct AccessTokenDetailRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let accessToken: String

	// MARK: - Initializers
	internal init(context: RequestContext, accessToken: String) {
		self.context = context
		self.accessToken = accessToken
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<AccessToken> {
		let tokenID = self.accessToken.components(separatedBy: "|")[0]
		let request = KKRequest<ResourceCollection<AccessToken>>(
			path: KKEndpoint.Me.AccessTokens.details(tokenID).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
