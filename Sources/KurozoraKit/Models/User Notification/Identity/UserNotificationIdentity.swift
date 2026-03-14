//
//  UserNotificationIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/10/2025.
//  MIT License
//

import Foundation

/// A root object that stores information about a user notification identity resource.
public struct UserNotificationIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a user notification identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the user notification.
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
