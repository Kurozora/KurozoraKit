//
//  ReviewIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/03/2024.
//  MIT License
//

import Foundation

/// A root object that stores information about a review identity resource.
public struct ReviewIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a review identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the review.
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
