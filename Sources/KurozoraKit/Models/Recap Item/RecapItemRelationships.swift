//
//  RecapItemRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 04/01/2024.
//  MIT License
//

import Foundation

extension RecapItem {
	/// A root object that stores information about recap item relationships, such as the shows, genres, and characters that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The shows belonging to the recap.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games belonging to the recap.
		public let games: ResourceCollection<GameIdentity>?

		/// The literature belonging to the recap.
		public let literatures: ResourceCollection<LiteratureIdentity>?

		/// The episodes belonging to the recap.
		public let episodes: ResourceCollection<EpisodeIdentity>?

		/// The shows belonging to the recap.
		public let showSongs: ResourceCollection<ShowSong>?

		/// The genres belonging to the recap.
		public let genres: ResourceCollection<GenreIdentity>?

		/// The themes belonging to the recap.
		public let themes: ResourceCollection<ThemeIdentity>?

		/// The characters belonging to the recap.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the recap.
		public let people: ResourceCollection<PersonIdentity>?
	}
}
