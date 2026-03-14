//
//  KurozoraKit+Session.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of sessions for the authenticated user.
	///
	/// - Parameters:
	///   - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///   - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``SessionIdentityResponse`` containing the session identities.
	public func getSessions(next: String? = nil, limit: Int = 25) async throws -> SessionIdentityResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<SessionIdentityResponse>(
			path: next ?? KKEndpoint.Me.Sessions.index.endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the session details for the given session identity.
	///
	/// - Parameter sessionIdentity: The identity of the session to fetch details for.
	///
	/// - Returns: A ``SessionResponse`` containing the session details.
	public func getDetails(forSession sessionIdentity: SessionIdentity) async throws -> SessionResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<SessionResponse>(
			path: KKEndpoint.Me.Sessions.details(sessionIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Deletes the specified session from the user's active sessions.
	///
	/// - Parameter sessionIdentity: The identity of the session to delete.
	///
	/// - Returns: A ``KKSuccess`` indicating whether the request succeeded.
	public func deleteSession(_ sessionIdentity: SessionIdentity) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Sessions.delete(sessionIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
