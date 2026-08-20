//
//  ReviewRevision.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a superseded version of a review.
public struct ReviewRevision: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the review revision.
	public let attributes: ReviewRevision.Attributes

	// MARK: - Functions
	public static func == (lhs: ReviewRevision, rhs: ReviewRevision) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
