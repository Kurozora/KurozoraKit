//
//  ExploreCategoryRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/08/2020.
//  MIT License
//

import Foundation

extension ExploreCategory {
	/// A root object that stores information about explore category relationships, such as the shows, genres, and characters that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The shows belonging to the explore category.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games belonging to the explore category.
		public let games: ResourceCollection<GameIdentity>?

		/// The literature belonging to the explore category.
		public let literatures: ResourceCollection<LiteratureIdentity>?

		/// The episodes belonging to the explore category.
		public let episodes: ResourceCollection<EpisodeIdentity>?

		/// The shows belonging to the explore category.
		public let showSongs: ResourceCollection<ShowSong>?

		/// The genres belonging to the explore category.
		public let genres: ResourceCollection<GenreIdentity>?

		/// The themes belonging to the explore category.
		public let themes: ResourceCollection<ThemeIdentity>?

		/// The characters belonging to the explore category.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the explore category.
		public let people: ResourceCollection<PersonIdentity>?

		/// The Re:CAP belonging to the explore category.
		public let recaps: ResourceCollection<Recap>?
	}
}
