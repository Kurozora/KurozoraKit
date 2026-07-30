//
//  KotodamaDailyPuzzleAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaDailyPuzzle {
	/// A root object that stores information about a single daily puzzle, such as the puzzle's number, and date.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The number of the puzzle.
		public let puzzleNumber: Int

		/// The date of the puzzle.
		public let puzzleDate: String?

		/// The date the next daily puzzle unlocks.
		public let nextPuzzleAt: Date?
	}
}
