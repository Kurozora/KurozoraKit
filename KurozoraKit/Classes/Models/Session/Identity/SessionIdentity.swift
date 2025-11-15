//
//  SessionIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/07/2022.
//

import Foundation

/// A root object that stores information about a session identity resource.
public struct SessionIdentity: Codable, Hashable, Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "sessions"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: SessionIdentity, rhs: SessionIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
