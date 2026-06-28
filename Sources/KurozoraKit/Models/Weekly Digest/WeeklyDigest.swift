//
//  WeeklyDigest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about the authenticated user's weekly digest.
public struct WeeklyDigest: Codable, Sendable {
	// MARK: - Properties
	/// The ordered sections that make up the digest.
	public let sections: [WeeklyDigestSection]

	// MARK: - Initializers
	/// Creates a weekly digest from its ordered sections.
	///
	/// - Parameter sections: The ordered sections that make up the digest.
	public init(sections: [WeeklyDigestSection]) {
		self.sections = sections
	}
}
