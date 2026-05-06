//
//  ParentalGuideVoteUpdate.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 08/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores the authenticated user's helpfulness state on an entry after a vote.
public struct ParentalGuideVoteUpdate: Codable, Sendable {
	// MARK: - Properties
	/// Whether the authenticated user has marked the entry as helpful.
	public let isHelpful: Bool?
}
