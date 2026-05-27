//
//  TimeoutReason.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// The set of available timeout reason categories.
public enum TimeoutReason: Int, Codable, Sendable, CaseIterable {
	// MARK: - Cases
	/// Indicates the suspension was issued for spam.
	case spam = 1

	/// Indicates the suspension was issued for harassment.
	case harassment = 2

	/// Indicates the suspension was issued for posting NSFW content.
	case nsfw = 3

	/// Indicates the suspension was issued for impersonating another user or entity.
	case impersonation = 4

	/// Indicates the suspension was issued for hate speech.
	case hate = 5

	/// Indicates the suspension was issued for a reason not captured by another case.
	case other = 6
}
