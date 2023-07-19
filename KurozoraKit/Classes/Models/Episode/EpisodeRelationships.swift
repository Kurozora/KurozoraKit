//
//  EpisodeRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/07/2023.
//

extension Episode {
	/// A root object that stores information about episode relationships, such as the season, and show that belong to it.
	public struct Relationships: Codable {
		// MARK: - Properties
		/// The season belonging to the episode.
		public let season: SeasonResponse?

		/// The show belonging to the episode.
		public let show: ShowResponse?
	}
}
