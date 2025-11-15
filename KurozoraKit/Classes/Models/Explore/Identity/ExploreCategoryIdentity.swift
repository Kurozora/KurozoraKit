//
//  ExploreCategoryIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/06/2022.
//

import Foundation

/// A root object that stores information about an explore category identity resource.
public struct ExploreCategoryIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "explore"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: ExploreCategoryIdentity, rhs: ExploreCategoryIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
