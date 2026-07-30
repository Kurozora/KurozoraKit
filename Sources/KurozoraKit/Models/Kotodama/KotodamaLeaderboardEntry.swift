//
//  KotodamaLeaderboardEntry.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama leaderboard entry resource.
public struct KotodamaLeaderboardEntry: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the leaderboard entry.
	public let attributes: KotodamaLeaderboardEntry.Attributes

	/// The relationships belonging to the leaderboard entry.
	public let relationships: KotodamaLeaderboardEntry.Relationships?

	/// The player behind the entry.
	public var user: User? {
		return self.relationships?.users.data.first
	}

	// MARK: - Functions
	public static func == (lhs: KotodamaLeaderboardEntry, rhs: KotodamaLeaderboardEntry) -> Bool {
		return lhs.id == rhs.id && lhs.attributes.rank == rhs.attributes.rank
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
		hasher.combine(self.attributes.rank)
	}
}

// MARK: - Relationships
extension KotodamaLeaderboardEntry {
	/// A root object that stores information about leaderboard entry relationships, such as the player that belongs to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The player behind the entry.
		public let users: ResourceCollection<User>
	}
}
