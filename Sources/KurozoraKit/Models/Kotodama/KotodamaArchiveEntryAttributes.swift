//
//  KotodamaArchiveEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaArchiveEntry {
	/// A root object that stores information about a single archive entry, such as the entry's number, and date.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The number of the puzzle.
		public let puzzleNumber: Int

		/// The date of the puzzle.
		public let puzzleDate: String?

		/// Whether the authenticated user has solved the puzzle.
		public let isSolved: Bool

		/// Whether the authenticated user has finished a game for the puzzle.
		public let isFinished: Bool?
	}
}
