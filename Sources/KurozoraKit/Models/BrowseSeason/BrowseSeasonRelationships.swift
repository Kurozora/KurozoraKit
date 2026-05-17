//
//  BrowseSeasonRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

import Foundation

extension BrowseSeason {
	/// A root object that stores information about browse season relationships, such as the shows, literatures, and games that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The shows related to the browse season.
		public let shows: ResourceCollection<Show>?

		/// The literatures related to the browse season.
		public let literatures: ResourceCollection<Literature>?

		/// The games related to the browse season.
		public let games: ResourceCollection<Game>?
	}
}
