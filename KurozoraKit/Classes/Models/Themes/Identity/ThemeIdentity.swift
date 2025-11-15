//
//  ThemeIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/02/2022.
//

import Foundation

/// A root object that stores information about a theme identity resource.
public struct ThemeIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: String) {
		self.id = KurozoraItemID(id)
		self.type = "themes"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: ThemeIdentity, rhs: ThemeIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
