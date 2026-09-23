//
//  RecapEntryRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

extension RecapEntry {
	/// The relationships of a recap entry.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The show of the entry.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The literature of the entry.
		public let literatures: ResourceCollection<LiteratureIdentity>?

		/// The game of the entry.
		public let games: ResourceCollection<GameIdentity>?

		/// The genre of the entry.
		public let genres: ResourceCollection<GenreIdentity>?

		/// The theme of the entry.
		public let themes: ResourceCollection<ThemeIdentity>?

		/// The studio of the entry.
		public let studios: ResourceCollection<StudioIdentity>?

		/// The character of the entry.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The person of the entry.
		public let people: ResourceCollection<PersonIdentity>?
	}
}
