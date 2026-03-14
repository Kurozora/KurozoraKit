//
//  EpisodeFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying episodes.
public struct EpisodeFilter {
	// MARK: - Properties
	/// The episode duration in minutes to filter by.
	public let duration: Int?

	/// Whether to filter by filler episodes.
	public let isFiller: Bool?

	/// Whether to filter by NSFW episodes.
	public let isNSFW: Bool?

	/// Whether to filter by special episodes.
	public let isSpecial: Bool?

	/// Whether to filter by premiere episodes.
	public let isPremiere: Bool?

	/// Whether to filter by finale episodes.
	public let isFinale: Bool?

	/// The episode number within its season to filter by.
	public let number: Int?

	/// The absolute episode number across all seasons to filter by.
	public let numberTotal: Int?

	/// The season identifier to filter by.
	public let season: Int?

	/// The TV rating identifier to filter by.
	public let tvRating: Int?

	/// The air start date to filter by, expressed as a time interval since the reference date.
	public let startedAt: TimeInterval?

	/// The air end date to filter by, expressed as a time interval since the reference date.
	public let endedAt: TimeInterval?

	// MARK: - Initializers
	public init(duration: Int? = nil, isFiller: Bool? = nil, isNSFW: Bool? = nil, isSpecial: Bool? = nil, isPremiere: Bool? = nil, isFinale: Bool? = nil, number: Int? = nil, numberTotal: Int? = nil, season: Int? = nil, tvRating: Int? = nil, startedAt: TimeInterval? = nil, endedAt: TimeInterval? = nil) {
		self.duration = duration
		self.isFiller = isFiller
		self.isNSFW = isNSFW
		self.isSpecial = isSpecial
		self.isPremiere = isPremiere
		self.isFinale = isFinale
		self.number = number
		self.numberTotal = numberTotal
		self.season = season
		self.tvRating = tvRating
		self.startedAt = startedAt
		self.endedAt = endedAt
	}
}

// MARK: - Filterable
extension EpisodeFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [
			"duration": self.duration,
			"is_filler": self.isFiller,
			"is_nsfw": self.isNSFW,
			"is_special": self.isSpecial,
			"is_premiere": self.isPremiere,
			"is_finale": self.isFinale,
			"number": self.number,
			"number_total": self.numberTotal,
			"season_id": self.season,
			"tv_rating_id": self.tvRating,
			"started_at": self.startedAt,
			"ended_at": self.endedAt
		]
	}
}
