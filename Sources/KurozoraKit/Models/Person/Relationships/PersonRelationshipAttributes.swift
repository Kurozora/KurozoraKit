//
//  PersonRelationshipAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/10/2026.
//  MIT License
//

import Foundation

extension PersonRelationship {
	/// A root object that stores information about a single person relationship.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The relation to the related person.
		public let relation: MediaRelation

		/// The date the relationship started.
		public let startedAt: Date?

		/// The date the relationship ended.
		public let endedAt: Date?
	}
}
