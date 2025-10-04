//
//  MediaRelationships.swift
//  Kurozora
//
//  Created by Khoren Katklian on 27/10/2024.
//

import Foundation

extension Media {
	/// A root object that stores information about media relationships, such as the episodes, and games that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The episodes belonging to the media.
		public let episodes: EpisodeIdentityResponse?

		/// The games belonging to the media.
		public let games: GameIdentityResponse?

		/// The literatures belonging to the media.
		public let literatures: LiteratureIdentityResponse?

		/// The shows belonging to the media.
		public let shows: ShowIdentityResponse?
	}
}
