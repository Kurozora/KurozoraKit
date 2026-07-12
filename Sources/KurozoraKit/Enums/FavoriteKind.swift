//
//  FavoriteKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// The set of available favorite kinds.
public enum FavoriteKind: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// The shows favorites of the user.
	case shows = 0

	/// The literature favorites of the user.
	case literatures = 1

	/// The games favorites of the user.
	case games = 2

	/// The character favorites of the user.
	case characters = 3

	/// The person favorites of the user.
	case people = 4

	/// The studio favorites of the user.
	case studios = 5

	/// The song favorites of the user.
	case songs = 6
}
