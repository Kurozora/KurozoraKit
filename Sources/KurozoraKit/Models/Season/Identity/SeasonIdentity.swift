//
//  SeasonIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/02/2022.
//  MIT License
//

import Foundation

/// A root object that stores information about a season identity resource.
public struct SeasonIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a season identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the season.
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "seasons"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: SeasonIdentity, rhs: SeasonIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
