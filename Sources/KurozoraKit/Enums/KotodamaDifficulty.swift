//
//  KotodamaDifficulty.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

/// The set of available Kotodama difficulties.
///
/// ```
/// case easy = 1
/// case normal = 2
/// case hard = 3
/// ```
public enum KotodamaDifficulty: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The answer belongs to a widely known subject.
	case easy = 1

	/// The answer belongs to a moderately known subject.
	case normal = 2

	/// The answer belongs to a lesser known subject.
	case hard = 3
}
