//
//  ReviewRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/07/2023.
//  MIT License
//

import Foundation

extension Review {
	/// A root object that stores information about review relationships, such as the user that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The shows belonging to the rating.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games belonging to the rating.
		public let games: ResourceCollection<GameIdentity>?

		/// The literature belonging to the rating.
		public let literatures: ResourceCollection<LiteratureIdentity>?

		/// The episodes belonging to the rating.
		public let episodes: ResourceCollection<EpisodeIdentity>?

		/// The songs belonging to the rating.
		public let songs: ResourceCollection<SongIdentity>?

		/// The characters belonging to the rating.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the rating.
		public let people: ResourceCollection<PersonIdentity>?

		/// The studios belonging to the rating.
		public let studios: ResourceCollection<StudioIdentity>?

		/// The users belonging to the review.
		public let users: ResourceCollection<User>?

		// MARK: - Properties
		/// The identifier of the reviewed item, sourced from whichever per-type key the server populated.
		public var reviewedID: KurozoraItemID? {
			if let id = self.shows?.data.first?.id { return id }
			if let id = self.games?.data.first?.id { return id }
			if let id = self.literatures?.data.first?.id { return id }
			if let id = self.episodes?.data.first?.id { return id }
			if let id = self.songs?.data.first?.id { return id }
			if let id = self.characters?.data.first?.id { return id }
			if let id = self.people?.data.first?.id { return id }
			if let id = self.studios?.data.first?.id { return id }
			return nil
		}
	}
}
