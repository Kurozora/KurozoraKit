//
//  KotodamaArchiveRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches a past Kotodama puzzle and the authenticated user's game for it.
public struct KotodamaArchiveRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let date: Date

	// MARK: - Initializers
	internal init(context: RequestContext, date: Date) {
		self.context = context
		self.date = date
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaGame> {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd"

		let request = KKRequest<ResourceCollection<KotodamaGame>>(
			path: KKEndpoint.Minigames.Kotodama.archive(dateFormatter.string(from: self.date)).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
