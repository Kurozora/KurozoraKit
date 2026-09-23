//
//  RecapEntry.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

/// A ranked entry of a recap.
public struct RecapEntry: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the recap entry.
	public let attributes: RecapEntry.Attributes

	/// The relationships belonging to the recap entry.
	public let relationships: RecapEntry.Relationships?

	// MARK: - Functions
	public static func == (lhs: RecapEntry, rhs: RecapEntry) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
