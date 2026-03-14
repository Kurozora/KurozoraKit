//
//  LiteratureIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/01/2023.
//  MIT License
//

import Foundation

/// A root object that stores information about a literature identity resource.
public struct LiteratureIdentity: KurozoraItem, IdentityResource, Hashable, Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a literature identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the literature.
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "literatures"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: LiteratureIdentity, rhs: LiteratureIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
