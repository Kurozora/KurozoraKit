//
//  MuseumYear.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a museum year resource.
public struct MuseumYear: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The release year the museum entries belong to.
	public let year: Int

	/// The number of museum entries released in the year.
	public let count: Int

	// MARK: - Functions
	public static func == (lhs: MuseumYear, rhs: MuseumYear) -> Bool {
		return lhs.year == rhs.year && lhs.count == rhs.count
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.year)
		hasher.combine(self.count)
	}
}
