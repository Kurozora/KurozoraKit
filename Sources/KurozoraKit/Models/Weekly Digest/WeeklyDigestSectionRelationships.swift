//
//  WeeklyDigestSectionRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

extension WeeklyDigestSection {
	/// A root object that stores information about a weekly digest section's relationships, such as the shows, games, episodes, and people that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The shows belonging to the section.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games belonging to the section.
		public let games: ResourceCollection<GameIdentity>?

		/// The episodes belonging to the section.
		public let episodes: ResourceCollection<EpisodeIdentity>?

		/// The people belonging to the section.
		public let people: ResourceCollection<PersonIdentity>?
	}
}
