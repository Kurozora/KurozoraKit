//
//  StudioIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/02/2022.
//

import Foundation

/// A root object that stores information about a studio identity resource.
public struct StudioIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "studios"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: StudioIdentity, rhs: StudioIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
