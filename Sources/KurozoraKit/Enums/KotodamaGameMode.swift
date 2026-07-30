//
//  KotodamaGameMode.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

/// The set of available Kotodama game modes.
///
/// ```
/// case daily = 1
/// case unlimited = 2
/// case versus = 3
/// case archive = 4
/// ```
public enum KotodamaGameMode: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The puzzle every player shares for the day.
	case daily = 1

	/// A practice puzzle drawn at random.
	case unlimited = 2

	/// A puzzle shared with another player through a seed.
	case versus = 3

	/// A past daily puzzle replayed from the archive.
	case archive = 4

	// MARK: - Properties
	/// A Boolean value indicating whether the mode counts towards streaks and stats.
	public var isRanked: Bool {
		switch self {
		case .daily, .archive:
			return true
		case .unlimited, .versus:
			return false
		}
	}
}
