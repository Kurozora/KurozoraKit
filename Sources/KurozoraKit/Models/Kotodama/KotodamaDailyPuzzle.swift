//
//  KotodamaDailyPuzzle.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a Kotodama daily puzzle resource.
public struct KotodamaDailyPuzzle: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The attributes belonging to the daily puzzle.
	public let attributes: KotodamaDailyPuzzle.Attributes

	// MARK: - Functions
	public static func == (lhs: KotodamaDailyPuzzle, rhs: KotodamaDailyPuzzle) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
