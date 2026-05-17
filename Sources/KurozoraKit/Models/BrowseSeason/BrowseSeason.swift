//
//  BrowseSeason.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a seasonal browse resource.
public struct BrowseSeason: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the browse season.
	public let attributes: BrowseSeason.Attributes

	/// The relationships belonging to the browse season.
	public let relationships: BrowseSeason.Relationships

	// MARK: - Functions
	public static func == (lhs: BrowseSeason, rhs: BrowseSeason) -> Bool {
		return lhs.type == rhs.type && lhs.attributes.type.name == rhs.attributes.type.name
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.type)
		hasher.combine(self.attributes.type.name)
	}
}
