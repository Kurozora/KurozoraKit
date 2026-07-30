//
//  KotodamaArchiveEntry.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama archive entry resource.
public struct KotodamaArchiveEntry: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the archive entry.
	public let attributes: KotodamaArchiveEntry.Attributes

	// MARK: - Functions
	public static func == (lhs: KotodamaArchiveEntry, rhs: KotodamaArchiveEntry) -> Bool {
		return lhs.id == rhs.id
			&& lhs.attributes.isSolved == rhs.attributes.isSolved
			&& lhs.attributes.isFinished == rhs.attributes.isFinished
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
		hasher.combine(self.attributes.isSolved)
		hasher.combine(self.attributes.isFinished)
	}
}
