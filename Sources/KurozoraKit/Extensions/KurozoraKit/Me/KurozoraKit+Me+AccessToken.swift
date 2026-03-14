//
//  KurozoraKit+AccessToken.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of access tokens for the authenticated user.
	///
	/// - Parameters:
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An ``AccessTokenResponse`` containing the requested access tokens.
	public func getAccessTokens(next: String? = nil, limit: Int = 25) async throws -> AccessTokenResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<AccessTokenResponse>(
			path: next ?? KKEndpoint.Me.AccessTokens.index.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the details for the given access token.
	///
	/// - Parameter accessToken: The access token string to retrieve details for.
	///
	/// - Returns: An ``AccessTokenResponse`` containing the token details.
	public func getDetails(forAccessToken accessToken: String) async throws -> AccessTokenResponse {
		let tokenID = accessToken.components(separatedBy: "|")[0]
		let request = KKRequest<AccessTokenResponse>(
			path: KKEndpoint.Me.AccessTokens.details(tokenID).endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}

	/// Updates the current access token with the given APN device token.
	///
	/// - Parameter apnDeviceToken: The Apple Push Notification device token to associate with the access token.
	///
	/// - Returns: A ``KKSuccess`` indicating the update succeeded.
	public func updateAccessToken(withAPNToken apnDeviceToken: String) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let tokenID = self.authenticationKey.components(separatedBy: "|")[0]
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.update(tokenID).endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(["apn_device_token": apnDeviceToken])
		)
		return try await self.client.send(request)
	}

	/// Deletes the specified access token from the user's active sessions.
	///
	/// - Parameter accessToken: The access token string to delete.
	///
	/// - Returns: A ``KKSuccess`` indicating the deletion succeeded.
	public func deleteAccessToken(_ accessToken: String) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let tokenID = accessToken.components(separatedBy: "|")[0]
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.delete(tokenID).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Signs out the authenticated user by invalidating the current access token.
	///
	/// - Returns: A ``KKSuccess`` indicating the sign out succeeded.
	public func signOut() async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let tokenID = self.authenticationKey.components(separatedBy: "|")[0]
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.AccessTokens.delete(tokenID).endpointValue,
			method: .post,
			headers: headers
		)

		do {
			let successResponse = try await self.client.send(request)
			self.authenticationKey = ""
			User.current = nil
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
			return successResponse
		} catch let error as KKAPIError {
			print("❌ Received sign out error — server message:", error.message)
			throw error
		} catch {
			print("❌ Received sign out error:", error.localizedDescription)
			throw error
		}
	}
}
