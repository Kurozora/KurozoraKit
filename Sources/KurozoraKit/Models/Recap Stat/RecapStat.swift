//
//  RecapStat.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

/// A habit or activity stat of a recap period.
public struct RecapStat: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the recap stat.
	public let attributes: RecapStat.Attributes

	/// The relationships belonging to the recap stat.
	public let relationships: RecapStat.Relationships?

	// MARK: - Functions
	public static func == (lhs: RecapStat, rhs: RecapStat) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
