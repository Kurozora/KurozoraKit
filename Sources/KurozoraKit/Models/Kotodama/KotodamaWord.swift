//
//  KotodamaWord.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama word resource.
public struct KotodamaWord: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the word.
	public let attributes: KotodamaWord.Attributes

	/// The relationships belonging to the word.
	public let relationships: KotodamaWord.Relationships?

	/// The identity of the subject the answer was mined from.
	public var subject: KotodamaSubjectIdentity? {
		return self.relationships?.subjects?.data.first
	}

	/// The kind of the subject, available once the poster is revealed.
	public var subjectKind: KotodamaSubjectKind? {
		guard let subjectType = self.attributes.subjectType else {
			return self.subject?.kind
		}

		return KotodamaSubjectKind(rawValue: subjectType)
	}

	// MARK: - Functions
	public static func == (lhs: KotodamaWord, rhs: KotodamaWord) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}

// MARK: - Relationships
extension KotodamaWord {
	/// A root object that stores information about word relationships, such as the subject that belongs to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The subject the answer was mined from.
		public let subjects: ResourceCollection<KotodamaSubjectIdentity>?
	}
}
