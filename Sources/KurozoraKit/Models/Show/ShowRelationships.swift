//
//  ShowRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/08/2020.
//  MIT License
//

import Foundation

extension Show {
	/// A root object that stores information about show relationships, such as the studios, and cast that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The cast belonging to the show.
		public let cast: ResourceCollection<CastIdentity>?

		/// The characters belonging to the show.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the show.
		public let people: ResourceCollection<PersonIdentity>?

		/// The shows related to the show.
		public let relatedShows: ResourceCollection<RelatedShow>?

		/// The games related to the show.
		public let relatedGames: ResourceCollection<RelatedGame>?

		/// The literatures related to the show.
		public let relatedLiteratures: ResourceCollection<RelatedLiterature>?

		/// The seasons belonging to the show.
		public let seasons: ResourceCollection<SeasonIdentity>?

		/// The relationships belonging to the show.
		public let showSongs: ResourceCollection<ShowSong>?

		/// The songs belonging to the game.
		public let songs: ResourceCollection<SongIdentity>?

		/// The staff belonging to the show.
		public let staff: ResourceCollection<StaffIdentity>?

		/// The studios belonging to the show.
		public let studios: ResourceCollection<StudioIdentity>?
	}
}
