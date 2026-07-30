//
//  KotodamaGame.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama game resource.
public struct KotodamaGame: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the game.
	public let attributes: KotodamaGame.Attributes

	/// The relationships belonging to the game.
	public let relationships: KotodamaGame.Relationships?

	/// The word being guessed.
	public var word: KotodamaWord? {
		return self.relationships?.words?.data.first
	}

	/// The daily puzzle the game belongs to.
	public var dailyPuzzle: KotodamaDailyPuzzle? {
		return self.relationships?.dailyPuzzles?.data.first
	}

	/// The challenger's game, present when joining a versus game.
	public var challenger: KotodamaGame? {
		return self.relationships?.challengers?.data.first
	}

	// MARK: - Functions
	public static func == (lhs: KotodamaGame, rhs: KotodamaGame) -> Bool {
		return lhs.id == rhs.id && lhs.attributes.guessCount == rhs.attributes.guessCount
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
		hasher.combine(self.attributes.guessCount)
	}
}

// MARK: - Relationships
extension KotodamaGame {
	/// A root object that stores information about game relationships, such as the word, and daily puzzle that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The word being guessed.
		public let words: ResourceCollection<KotodamaWord>?

		/// The daily puzzle the game belongs to.
		public let dailyPuzzles: ResourceCollection<KotodamaDailyPuzzle>?

		/// The challenger's game, present when joining a versus game.
		public let challengers: ResourceCollection<KotodamaGame>?
	}
}
