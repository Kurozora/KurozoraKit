//
//  LiteratureRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/01/2023.
//  MIT License
//

import Foundation

extension Literature {
	/// A root object that stores information about literature relationships, such as the studios, and cast that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The cast belonging to the literature.
		public let cast: ResourceCollection<CastIdentity>?

		/// The characters belonging to the literature.
		public let characters: ResourceCollection<CharacterIdentity>?

		/// The people belonging to the literature.
		public let people: ResourceCollection<PersonIdentity>?

		/// The shows related to the literature.
		public let relatedShows: ResourceCollection<RelatedShow>?

		/// The games related to the literature.
		public let relatedGames: ResourceCollection<RelatedGame>?

		/// The literatures related to the literature.
		public let relatedLiteratures: ResourceCollection<RelatedLiterature>?

		/// The staff belonging to the literature.
		public let staff: ResourceCollection<StaffIdentity>?

		/// The studios belonging to the literature.
		public let studios: ResourceCollection<StudioIdentity>?
	}
}
