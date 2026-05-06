//
//  ParentalGuideEntryIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a parental guide entry identity resource.
public struct ParentalGuideEntryIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a parental guide entry identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the parental guide entry.
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "parentalguide-entries"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: ParentalGuideEntryIdentity, rhs: ParentalGuideEntryIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
