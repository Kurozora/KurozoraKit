//
//  KotodamaUserStatsAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaUserStats {
	/// A root object that stores information about a player's record, such as the player's streak, and win rate.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The number of consecutive dailies solved.
		public let currentStreak: Int

		/// The longest run of consecutive dailies solved.
		public let maxStreak: Int

		/// The number of ranked games finished.
		public let gamesPlayed: Int

		/// The number of ranked games won.
		public let gamesWon: Int

		/// The share of ranked games won, between `0` and `1`.
		public let winRate: Double

		/// The number of wins per guess count, keyed by guess count.
		public let guessDistribution: [String: Int]

		/// The average number of guesses across wins.
		public let averageGuesses: Double

		/// The average time spent per ranked game in milliseconds.
		public let averageDurationMs: Int

		/// The date of the most recent daily played.
		public let lastDailyDate: String?
	}
}
