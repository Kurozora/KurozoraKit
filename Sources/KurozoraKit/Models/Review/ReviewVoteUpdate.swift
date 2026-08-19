//
//  ReviewVoteUpdate.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores the authenticated user's helpfulness state on a review after a vote.
public struct ReviewVoteUpdate: Codable, Sendable {
	// MARK: - Properties
	/// Whether the authenticated user has marked the review as helpful.
	public let isHelpful: Bool?
}
