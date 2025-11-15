//
//  Genre.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/01/2019.
//

import Foundation

/// A root object that stores information about a genre resource.
public struct Genre: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the genre.
	public let attributes: Genre.Attributes

	// MARK: - Functions
	public static func == (lhs: Genre, rhs: Genre) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
