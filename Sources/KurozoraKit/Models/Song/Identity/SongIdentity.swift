//
//  SongIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/02/2022.
//  MIT License
//

import Foundation

/// A root object that stores information about a song identity resource.
public struct SongIdentity: KurozoraItem, IdentityResource, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	// MARK: - Initializers
	/// Creates a song identity with the given identifier.
	///
	/// - Parameter id: The unique identifier of the song.
	public init(id: KurozoraItemID) {
		self.id = id
		self.type = "songs"
		self.href = ""
	}

	// MARK: - Functions
	public static func == (lhs: SongIdentity, rhs: SongIdentity) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
