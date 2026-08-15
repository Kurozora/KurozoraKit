//
//  EmojiScore.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// The set of available emoji scores.
///
/// ```
/// case disliked
/// case neutral
/// case liked
/// ```
public enum EmojiScore: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// A negative reaction.
	case disliked = -1

	/// An indifferent reaction.
	case neutral = 0

	/// A positive reaction.
	case liked = 1

	// MARK: - Initializers
	/// Creates the emoji score a rating maps to.
	///
	/// - Parameter rating: The rating to map.
	public init?(rating: Double?) {
		guard let rating = rating, rating > 0.0 else { return nil }

		switch rating {
		case ...1.75:
			self = .disliked
		case ...3.25:
			self = .neutral
		default:
			self = .liked
		}
	}

	// MARK: - Properties
	/// The rating the emoji score maps to.
	public var score: Double {
		switch self {
		case .disliked:
			return 1.0
		case .neutral:
			return 2.5
		case .liked:
			return 4.5
		}
	}

	/// The emoji representing the score.
	public var emoji: String {
		switch self {
		case .disliked:
			return "🙁"
		case .neutral:
			return "😐"
		case .liked:
			return "😄"
		}
	}
}
