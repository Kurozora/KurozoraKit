//
//  KotodamaShareGrid.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama share grid resource.
public struct KotodamaShareGrid: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the share grid.
	public let attributes: KotodamaShareGrid.Attributes

	// MARK: - Functions
	public static func == (lhs: KotodamaShareGrid, rhs: KotodamaShareGrid) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
