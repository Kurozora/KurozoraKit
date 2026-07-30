//
//  KotodamaLeaderboardEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaLeaderboardEntry {
	/// A root object that stores information about a single leaderboard entry, such as the entry's rank, and time.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The position of the entry on the leaderboard.
		public let rank: Int

		/// The number of guesses spent.
		public let guessCount: Int

		/// The time spent on the game in milliseconds.
		public let durationMs: Int?

		/// The date the game was finished.
		public let finishedAt: Date?
	}
}
