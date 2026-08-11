//
//  KotodamaGameAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaGame {
	/// A root object that stores information about a single game, such as the game's mode, status, and guesses.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The mode the game is played in.
		public let mode: KotodamaGameMode?

		/// The status of the game.
		public let status: KotodamaGameStatus?

		/// The number of guesses spent.
		public let guessCount: Int

		/// The number of guesses allowed.
		public let maxGuesses: Int

		/// The date the game was started.
		public let startedAt: Date?

		/// The date the game was finished.
		public let finishedAt: Date?

		/// The time spent on the game in milliseconds.
		public let durationMs: Int?

		/// The seed other players use to join the game.
		public let versusSeed: String?

		/// The guesses submitted so far.
		public let guesses: [KotodamaGuess]

		// MARK: - CodingKeys
		private enum CodingKeys: String, CodingKey {
			case mode
			case status
			case guessCount
			case maxGuesses
			case startedAt
			case finishedAt
			case durationMs
			case versusSeed
			case guesses
		}
	}
}
