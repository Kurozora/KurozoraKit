//
//  GameFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying games.
public struct GameFilter {
	// MARK: - Properties
	/// The day of the week the game is published, represented as an integer.
	public let publicationDay: Int?

	/// The publication season identifier to filter by.
	public let publicationSeason: Int?

	/// The ISO 3166-1 country code of the game's country of origin.
	public let countryOfOrigin: String?

	/// The game duration in minutes to filter by.
	public let duration: Int?

	/// The publication date to filter by, expressed as a time interval since the reference date.
	public let publishedAt: TimeInterval?

	/// Whether to filter by NSFW games.
	public let isNSFW: Bool?

	/// The media type identifier to filter by.
	public let mediaType: Int?

	/// The source material identifier to filter by.
	public let source: Int?

	/// The game status identifier to filter by.
	public let status: Int?

	/// The TV rating identifier to filter by.
	public let tvRating: Int?

	/// The number of editions to filter by.
	public let editionCount: Int?

	// MARK: - Initializers
	public init(
		publicationDay: Int? = nil,
		publicationSeason: Int? = nil,
		countryOfOrigin: String? = nil,
		duration: Int? = nil,
		publishedAt: TimeInterval? = nil,
		isNSFW: Bool? = nil,
		mediaType: Int? = nil,
		source: Int? = nil,
		status: Int? = nil,
		tvRating: Int? = nil,
		editionCount: Int? = nil
	) {
		self.publicationDay = publicationDay
		self.publicationSeason = publicationSeason
		self.countryOfOrigin = countryOfOrigin
		self.duration = duration
		self.publishedAt = publishedAt
		self.isNSFW = isNSFW
		self.mediaType = mediaType
		self.source = source
		self.status = status
		self.tvRating = tvRating
		self.editionCount = editionCount
	}
}

// MARK: - Filterable
extension GameFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		return [
			"publication_day": self.publicationDay,
			"publication_season": self.publicationSeason,
			"country_id": self.countryOfOrigin,
			"duration": self.duration,
			"published_at": self.publishedAt,
			"is_nsfw": self.isNSFW,
			"media_type_id": self.mediaType,
			"source_id": self.source,
			"status_id": self.status,
			"tv_rating_id": self.tvRating,
			"edition_count": self.editionCount
		]
	}
}
