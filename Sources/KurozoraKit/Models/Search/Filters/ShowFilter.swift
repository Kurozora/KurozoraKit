//
//  ShowFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying shows.
public struct ShowFilter {
	// MARK: - Properties
	/// The day of the week the show airs, represented as an integer.
	public let airDay: Int?

	/// The airing season identifier to filter by.
	public let airSeason: Int?

	/// The airing time string to filter by.
	public let airTime: String?

	/// The ISO 3166-1 country code of the show's country of origin.
	public let countryOfOrigin: String?

	/// The episode duration in minutes to filter by.
	public let duration: Int?

	/// Whether to filter by NSFW shows.
	public let isNSFW: Bool?

	/// The air start date to filter by, expressed as a time interval since the reference date.
	public let startedAt: TimeInterval?

	/// The air end date to filter by, expressed as a time interval since the reference date.
	public let endedAt: TimeInterval?

	/// The media type identifier to filter by.
	public let mediaType: Int?

	/// The source material identifier to filter by.
	public let source: Int?

	/// The show status identifier to filter by.
	public let status: Int?

	/// The TV rating identifier to filter by.
	public let tvRating: Int?

	/// The number of seasons to filter by.
	public let seasonCount: Int?

	/// The number of episodes to filter by.
	public let episodeCount: Int?

	// MARK: - Initializers
	public init(
		airDay: Int? = nil,
		airSeason: Int? = nil,
		airTime: String? = nil,
		countryOfOrigin: String? = nil,
		duration: Int? = nil,
		isNSFW: Bool? = nil,
		startedAt: TimeInterval? = nil,
		endedAt: TimeInterval? = nil,
		mediaType: Int? = nil,
		source: Int? = nil,
		status: Int? = nil,
		tvRating: Int? = nil,
		seasonCount: Int? = nil,
		episodeCount: Int? = nil
	) {
		self.airDay = airDay
		self.airSeason = airSeason
		self.airTime = airTime
		self.countryOfOrigin = countryOfOrigin
		self.duration = duration
		self.isNSFW = isNSFW
		self.startedAt = startedAt
		self.endedAt = endedAt
		self.mediaType = mediaType
		self.source = source
		self.status = status
		self.tvRating = tvRating
		self.seasonCount = seasonCount
		self.episodeCount = episodeCount
	}
}

// MARK: - Filterable
extension ShowFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [
			"air_day": self.airDay,
			"air_season": self.airSeason,
			"air_time": self.airTime,
			"country_id": self.countryOfOrigin,
			"duration": self.duration,
			"started_at": self.startedAt,
			"is_nsfw": self.isNSFW,
			"ended_at": self.endedAt,
			"media_type_id": self.mediaType,
			"source_id": self.source,
			"status_id": self.status,
			"tv_rating_id": self.tvRating,
			"season_count": self.seasonCount,
			"episode_count": self.episodeCount
		]
	}
}
