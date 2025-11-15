//
//  ReviewIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/03/2024.
//

import Foundation

/// A root object that stores information about a user identity resource.
public struct ReviewIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "reviews"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: ReviewIdentity, rhs: ReviewIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
