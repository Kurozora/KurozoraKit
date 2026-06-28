//
//  WeeklyDigestSection.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a single weekly digest section resource.
public struct WeeklyDigestSection: Codable, Sendable, Identifiable, Hashable {
	// MARK: - Properties
	/// The stable identifier of the section.
	public let id: String

	/// The type of the resource.
	public let type: String

	/// The relative link to the resource.
	public let href: String

	/// The attributes belonging to the section.
	public let attributes: WeeklyDigestSection.Attributes

	/// The relationships belonging to the section.
	public let relationships: WeeklyDigestSection.Relationships?

	// MARK: - Functions
	public static func == (lhs: WeeklyDigestSection, rhs: WeeklyDigestSection) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
