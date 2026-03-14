//
//  GameIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/02/2023.
//  MIT License
//

import Foundation

/// A root object that stores information about a game identity resource.
public struct GameIdentity: KurozoraItem, IdentityResource, Hashable, Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a game identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the game.
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "games"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: GameIdentity, rhs: GameIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
