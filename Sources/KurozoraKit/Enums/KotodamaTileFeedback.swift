//
//  KotodamaTileFeedback.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

/// The set of available Kotodama tile feedback values.
///
/// ```
/// case hit = "H"
/// case present = "P"
/// case miss = "M"
/// ```
public enum KotodamaTileFeedback: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The letter is in the answer at this position.
	case hit = "H"

	/// The letter is in the answer at another position.
	case present = "P"

	/// The letter is not in the answer.
	case miss = "M"

	// MARK: - Properties
	/// The emoji representing the feedback in a shared grid.
	public var emojiValue: String {
		switch self {
		case .hit:
			return "🟧"
		case .present:
			return "🟪"
		case .miss:
			return "⬛"
		}
	}
}
