//
//  StudioRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/08/2020.
//  MIT License
//

import Foundation

extension Studio {
	/// A root object that stores information about studio relationships, such as the shows that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The studio' predecessors.
		public let predecessors: ResourceCollection<StudioIdentity>?

		/// The studio's successors.
		public let successors: ResourceCollection<StudioIdentity>?

		/// The shows created by the studio.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The games created by the studio.
		public let games: ResourceCollection<GameIdentity>?

		/// The literatures created by the studio.
		public let literatures: ResourceCollection<LiteratureIdentity>?
	}
}
