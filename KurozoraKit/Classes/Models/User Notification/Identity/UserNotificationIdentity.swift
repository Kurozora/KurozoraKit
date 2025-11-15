//
//  UserNotificationIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/10/2025.
//

import Foundation

/// A root object that stores information about a user notification identity resource.
public struct UserNotificationIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "notifications"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: UserNotificationIdentity, rhs: UserNotificationIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
