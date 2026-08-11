//
//  KKEndpoint+Minigames.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

// MARK: - Kotodama
extension KKEndpoint.Minigames {
	/// The set of available Kotodama API endpoint types.
	internal enum Kotodama {
		// MARK: - Cases
		/// The endpoint to today's daily puzzle.
		case daily

		/// The endpoint to a new unlimited game.
		case unlimited

		/// The endpoint to the index of past puzzles.
		case archiveIndex

		/// The endpoint to a past puzzle.
		case archive(_ date: String)

		/// The endpoint to create a versus game.
		case createVersus

		/// The endpoint to join a versus game.
		case joinVersus(_ seed: String)

		/// The endpoint to submit a guess against a game.
		case guess(_ gameID: KurozoraItemID)

		/// The endpoint to abandon a game.
		case abandon(_ gameID: KurozoraItemID)

		/// The endpoint to the leaderboard of a daily puzzle.
		case dailyLeaderboard(_ date: String?)

		/// The endpoint to the all-time streak leaderboard.
		case streakLeaderboard

		/// The endpoint to the authenticated user's stats.
		case myStats

		// MARK: - Properties
		/// The endpoint value of the Kotodama API type.
		var endpointValue: String {
			switch self {
			case .daily:
				return "kotodama/daily"
			case .unlimited:
				return "kotodama/unlimited"
			case .archiveIndex:
				return "kotodama/archive"
			case .archive(let date):
				return "kotodama/archive/\(date)"
			case .createVersus:
				return "kotodama/versus"
			case .joinVersus(let seed):
				return "kotodama/versus/\(seed)"
			case .guess(let gameID):
				return "kotodama/games/\(gameID)/guess"
			case .abandon(let gameID):
				return "kotodama/games/\(gameID)/abandon"
			case .dailyLeaderboard(let date):
				guard let date = date else {
					return "kotodama/leaderboards/daily"
				}
				return "kotodama/leaderboards/daily/\(date)"
			case .streakLeaderboard:
				return "kotodama/leaderboards/streak"
			case .myStats:
				return "kotodama/me/stats"
			}
		}
	}
}
