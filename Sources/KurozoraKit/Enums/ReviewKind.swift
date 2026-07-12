//
//  ReviewKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// The set of available review kinds.
public enum ReviewKind: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// The shows reviews of the user.
	case shows = 0

	/// The literature reviews of the user.
	case literatures = 1

	/// The games reviews of the user.
	case games = 2

	/// The character reviews of the user.
	case characters = 3

	/// The person reviews of the user.
	case people = 4

	/// The studio reviews of the user.
	case studios = 5

	/// The song reviews of the user.
	case songs = 6

	/// The episode reviews of the user.
	case episodes = 7
}
