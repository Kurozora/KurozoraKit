//
//  ParentalGuideEntry.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a parental guide entry resource.
public final class ParentalGuideEntry: KurozoraItem, IdentityResource, Hashable, @unchecked Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the parental guide entry.
	public var attributes: ParentalGuideEntry.Attributes

	// MARK: - Functions
	public static func == (lhs: ParentalGuideEntry, rhs: ParentalGuideEntry) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
