//
//  KotodamaGameStatus.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

/// The set of available Kotodama game statuses.
///
/// ```
/// case inProgress = 0
/// case won = 1
/// case lost = 2
/// case abandoned = 3
/// ```
public enum KotodamaGameStatus: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The game is still being played.
	case inProgress = 0

	/// The answer was guessed.
	case won = 1

	/// Every guess was spent without finding the answer.
	case lost = 2

	/// The game was left unfinished.
	case abandoned = 3

	// MARK: - Properties
	/// A Boolean value indicating whether the game has reached an end state.
	public var isFinished: Bool {
		switch self {
		case .inProgress:
			return false
		case .won, .lost, .abandoned:
			return true
		}
	}
}
