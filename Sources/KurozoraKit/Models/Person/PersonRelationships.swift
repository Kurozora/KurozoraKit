//
//  PersonRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2020.
//  MIT License
//

import Foundation

extension Person {
	/// A root object that stores information about person relationships, such as the shows, and characters that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The characters belonging to the person.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The shows belonging to the person.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games belonging to the person.
		public let games: ResourceCollection<GameIdentity>?

		/// The literatures belonging to the person.
		public let literatures: ResourceCollection<LiteratureIdentity>?
	}
}
