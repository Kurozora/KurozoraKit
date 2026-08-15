//
//  RatingStyle.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// The set of available rating styles.
///
/// ```
/// case quickReaction
/// case standard
/// case detailed
/// ```
public enum RatingStyle: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// A rating expressed as a single emoji reaction.
	case quickReaction = 0

	/// A rating expressed on a five star scale.
	case standard = 1

	/// A rating expressed as a score per rating category.
	case detailed = 2

	// MARK: - Properties
	/// The string value of a rating style.
	public var stringValue: String {
		switch self {
		case .quickReaction:
			return "Quick Reaction"
		case .standard:
			return "Standard"
		case .detailed:
			return "Detailed Review"
		}
	}
}
