//
//  RecapStatType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

/// The set of available recap stat types.
public enum RecapStatType: Int, Codable, Sendable {
	// MARK: - Cases
	/// The weekday with the most episodes watched.
	case busiestWeekday = 1

	/// The hour with the most episodes watched.
	case busiestHour = 2

	/// The longest run of consecutive watching days.
	case longestStreak = 3

	/// The day with the most episodes watched.
	case biggestBinge = 4

	/// The first title watched in the period.
	case firstTitle = 5

	/// The last title watched in the period.
	case lastTitle = 6

	/// The provider with the most episodes watched.
	case topProvider = 7

	/// The number of ratings given.
	case ratingsGiven = 8

	/// The average rating given.
	case averageRating = 9

	/// The number of reviews written.
	case reviewsWritten = 10

	/// The number of titles completed.
	case titlesCompleted = 11

	/// The number of titles dropped.
	case titlesDropped = 12

	/// The number of titles added.
	case titlesAdded = 13

	/// The number of favorites added.
	case favoritesAdded = 14

	/// The number of achievements earned.
	case achievementsEarned = 15
}
