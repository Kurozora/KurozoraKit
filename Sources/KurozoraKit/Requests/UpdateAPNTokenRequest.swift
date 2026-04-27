//
//  UpdateAPNTokenRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that updates the access token with a new APN device token.
public struct UpdateAPNTokenRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let accessTokenID: String
	private let apnDeviceToken: String

	// MARK: - Initializers
	internal init(context: RequestContext, accessTokenID: String, apnDeviceToken: String) {
		self.context = context
		self.accessTokenID = accessTokenID
		self.apnDeviceToken = apnDeviceToken
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.update(self.accessTokenID).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(["apn_device_token": self.apnDeviceToken])
		)
		return try await self.context.client.send(request)
	}
}
