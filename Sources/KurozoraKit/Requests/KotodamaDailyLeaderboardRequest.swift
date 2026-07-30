//
//  KotodamaDailyLeaderboardRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A request that fetches the leaderboard of a Kotodama daily puzzle.
///
/// ```swift
/// let leaderboardResponse = try await kurozoraKit
///     .kotodamaDailyLeaderboard()
///     .limit(50)
///     .response()
/// ```
public struct KotodamaDailyLeaderboardRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let date: Date?
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, date: Date? = nil, limit: Int = 25) {
		self.context = context
		self.date = date
		self._limit = limit
	}

	// MARK: - Modifiers
	/// Sets the maximum number of entries to return.
	///
	/// - Parameter limit: The number of entries to fetch.
	///
	/// - Returns: A copy of the request with the limit applied.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<KotodamaLeaderboardEntry> {
		var dateValue: String?

		if let date = self.date {
			let dateFormatter = DateFormatter()
			dateFormatter.locale = Locale(identifier: "en_US_POSIX")
			dateFormatter.dateFormat = "yyyy-MM-dd"
			dateValue = dateFormatter.string(from: date)
		}

		let request = KKRequest<ResourceCollection<KotodamaLeaderboardEntry>>(
			path: KKEndpoint.Minigames.Kotodama.dailyLeaderboard(dateValue).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: ["limit": self._limit]
		)
		return try await self.context.client.send(request)
	}
}
