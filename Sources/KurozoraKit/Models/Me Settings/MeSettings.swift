//
//  MeSettings.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about the authenticated user's settings resource.
public final class MeSettings: KurozoraItem, IdentityResource, Hashable, @unchecked Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the authenticated user's settings.
	public var attributes: MeSettings.Attributes

	// MARK: - Functions
	public static func == (lhs: MeSettings, rhs: MeSettings) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
