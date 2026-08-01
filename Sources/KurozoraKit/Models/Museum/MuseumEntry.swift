//
//  MuseumEntry.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a museum entry resource.
public struct MuseumEntry: KurozoraItem, IdentityResource, Hashable, Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the museum entry.
	public let attributes: MuseumEntry.Attributes

	// MARK: - Functions
	public static func == (lhs: MuseumEntry, rhs: MuseumEntry) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
