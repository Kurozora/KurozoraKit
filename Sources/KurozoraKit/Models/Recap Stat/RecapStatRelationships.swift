//
//  RecapStatRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

extension RecapStat {
	/// The relationships of a recap stat.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The show of the stat.
		public let shows: ResourceCollection<ShowIdentity>?

		/// The provider of the stat.
		public let providers: ResourceCollection<Provider>?
	}
}
