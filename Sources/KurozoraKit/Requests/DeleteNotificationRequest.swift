//
//  DeleteNotificationRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that deletes one, multiple, or all of the authenticated user's notifications.
public struct DeleteNotificationRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let identities: [any KurozoraItem]
	private let deleteAll: Bool

	// MARK: - Initializers
	internal init(context: RequestContext, identity: any KurozoraItem) {
		self.context = context
		self.identities = [identity]
		self.deleteAll = false
	}

	internal init(context: RequestContext, identities: [any KurozoraItem]) {
		self.context = context
		self.identities = identities
		self.deleteAll = false
	}

	internal init(context: RequestContext, deleteAll: Bool) {
		self.context = context
		self.identities = []
		self.deleteAll = deleteAll
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let parameters: [String: Any] = [
			"notification": self.deleteAll ? "all" : self.identities.map { $0.id.rawValue }.joined(separator: ",")
		]

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Notifications.delete.endpointValue,
			method: .post,
			headers: await self.context.headersWithSocketID(),
			body: .formURLEncoded(parameters)
		)
		return try await self.context.client.send(request)
	}
}
