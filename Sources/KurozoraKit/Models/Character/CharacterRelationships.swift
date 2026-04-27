//
//  CharacterRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2020.
//  MIT License
//

import Foundation

extension Character {
	/// A root object that stores information about character relationships, such as the shows, and people that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The people that played the character.
		public let people: ResourceCollection<PersonIdentity>?

		/// The shows in which the character showed up.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games in which the character showed up.
		public let games: ResourceCollection<GameIdentity>?

		/// The literatures in which the character showed up.
		public let literatures: ResourceCollection<LiteratureIdentity>?
	}
}
