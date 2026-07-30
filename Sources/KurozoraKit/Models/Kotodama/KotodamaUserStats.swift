//
//  KotodamaUserStats.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama user stats resource.
public struct KotodamaUserStats: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the user stats.
	public let attributes: KotodamaUserStats.Attributes

	// MARK: - Functions
	public static func == (lhs: KotodamaUserStats, rhs: KotodamaUserStats) -> Bool {
		return lhs.id == rhs.id && lhs.attributes == rhs.attributes
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
		hasher.combine(self.attributes)
	}
}
