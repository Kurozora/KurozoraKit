//
//  Editorial.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about an editorial resource.
public struct Editorial: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the editorial.
	public let attributes: Editorial.Attributes

	// MARK: - Functions
	public static func == (lhs: Editorial, rhs: Editorial) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
