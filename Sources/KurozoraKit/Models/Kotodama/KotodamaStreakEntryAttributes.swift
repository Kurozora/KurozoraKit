//
//  KotodamaStreakEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaStreakEntry {
	/// A root object that stores information about a single streak entry, such as the entry's rank, and streak.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The position of the entry on the leaderboard.
		public let rank: Int

		/// The number of consecutive dailies solved.
		public let currentStreak: Int

		/// The longest run of consecutive dailies solved.
		public let maxStreak: Int
	}
}
