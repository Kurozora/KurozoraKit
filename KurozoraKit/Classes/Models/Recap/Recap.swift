//
//  Recap.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 04/01/2024.
//

/// A root object that stores information about a recap resource.
public struct Recap: IdentityResource, Hashable {
	// MARK: - Properties
	public let id: String

	public let type: String

	public let href: String

	/// The attributes belonging to the show.
	public let attributes: Recap.Attributes

	// MARK: - Functions
	public static func == (lhs: Recap, rhs: Recap) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
