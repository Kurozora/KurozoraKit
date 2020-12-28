//
//  Studio.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/08/2020.
//

/**
	A root object that stores information about a studio resource.
*/
public struct Studio: IdentityResource, Hashable {
	// MARK: - Properties
	public let id: Int

	public let type: String

	public let href: String

	/// The attributes belonging to the studio.
	public let attributes: Studio.Attributes

	/// The relationships belonging to the studio.
	public let relationships: Studio.Relationships?

	// MARK: - Functions
	public static func == (lhs: Studio, rhs: Studio) -> Bool {
		lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
