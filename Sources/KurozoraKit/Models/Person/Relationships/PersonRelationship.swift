//
//  PersonRelationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/10/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a person relationship resource.
public struct PersonRelationship: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The id of the person relationship.
	public let id: UUID = UUID()

	/// The person related to the parent person.
	public let person: Person

	/// The attributes belonging to the person relationship.
	public var attributes: PersonRelationship.Attributes

	// MARK: - CodingKeys
	/// The coding keys used to decode the person relationship from a serialized representation.
	enum CodingKeys: String, CodingKey {
		case person
		case attributes
	}

	// MARK: - Functions
	public static func == (lhs: PersonRelationship, rhs: PersonRelationship) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
