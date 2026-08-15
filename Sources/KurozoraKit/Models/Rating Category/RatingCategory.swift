//
//  RatingCategory.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a rating category resource.
public final class RatingCategory: KurozoraItem, IdentityResource, Hashable, @unchecked Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the rating category.
	public var attributes: RatingCategory.Attributes

	// MARK: - Functions
	public static func == (lhs: RatingCategory, rhs: RatingCategory) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
