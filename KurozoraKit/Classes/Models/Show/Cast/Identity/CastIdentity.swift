//
//  CastIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/02/2022.
//

import Foundation

/// A root object that stores information about a season identity resource.
public struct CastIdentity: KurozoraItem, IdentityResource, Hashable, Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "cast"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: CastIdentity, rhs: CastIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
