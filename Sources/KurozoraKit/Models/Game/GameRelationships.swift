//
//  GameRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/02/2023.
//  MIT License
//

import Foundation

extension Game {
	/// A root object that stores information about game relationships, such as the studios, and cast that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The cast belonging to the game.
		public let cast: ResourceCollection<CastIdentity>?

		/// The characters belonging to the game.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the game.
		public let people: ResourceCollection<PersonIdentity>?

		/// The shows related to the game.
		public let relatedShows: ResourceCollection<RelatedShow>?

		/// The games related to the game.
		public let relatedGames: ResourceCollection<RelatedGame>?

		/// The literatures related to the game.
		public let relatedLiteratures: ResourceCollection<RelatedLiterature>?

		/// The songs belonging to the game.
		public let songs: ResourceCollection<SongIdentity>?

		/// The staff belonging to the game.
		public let staff: ResourceCollection<StaffIdentity>?

		/// The studios belonging to the game.
		public let studios: ResourceCollection<StudioIdentity>?
	}
}
