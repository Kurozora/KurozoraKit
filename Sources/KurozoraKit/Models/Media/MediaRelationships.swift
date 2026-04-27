//
//  MediaRelationships.swift
//  Kurozora
//
//  Created by Khoren Katklian on 27/10/2024.
//  MIT License
//

import Foundation

extension Media {
	/// A root object that stores information about media relationships, such as the episodes, and games that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The episodes belonging to the media.
		public let episodes: ResourceCollection<EpisodeIdentity>?

		/// The games belonging to the media.
		public let games: ResourceCollection<GameIdentity>?

		/// The literatures belonging to the media.
		public let literatures: ResourceCollection<LiteratureIdentity>?

		/// The shows belonging to the media.
		public let shows: ResourceCollection<ShowIdentity>?
	}
}
