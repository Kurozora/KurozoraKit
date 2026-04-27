//
//  LiteratureFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying literature.
public struct LiteratureFilter {
	// MARK: - Properties
	/// The day of the week the literature is published, represented as an integer.
	public let publicationDay: Int?

	/// The publication season identifier to filter by.
	public let publicationSeason: Int?

	/// The publication time string to filter by.
	public let publicationTime: String?

	/// The ISO 3166-1 country code of the literature's country of origin.
	public let countryOfOrigin: String?

	/// The reading duration in minutes to filter by.
	public let duration: Int?

	/// The start date to filter by, expressed as a time interval since the reference date.
	public let startedAt: TimeInterval?

	/// The end date to filter by, expressed as a time interval since the reference date.
	public let endedAt: TimeInterval?

	/// Whether to filter by NSFW literature.
	public let isNSFW: Bool?

	/// The media type identifier to filter by.
	public let mediaType: Int?

	/// The source material identifier to filter by.
	public let source: Int?

	/// The literature status identifier to filter by.
	public let status: Int?

	/// The TV rating identifier to filter by.
	public let tvRating: Int?

	/// The number of volumes to filter by.
	public let volumeCount: Int?

	/// The number of chapters to filter by.
	public let chapterCount: Int?

	/// The number of pages to filter by.
	public let pageCount: Int?

	// MARK: - Initializers
	public init(
		publicationDay: Int? = nil,
		publicationSeason: Int? = nil,
		publicationTime: String? = nil,
		countryOfOrigin: String? = nil,
		duration: Int? = nil,
		startedAt: TimeInterval? = nil,
		endedAt: TimeInterval? = nil,
		isNSFW: Bool? = nil,
		mediaType: Int? = nil,
		source: Int? = nil,
		status: Int? = nil,
		tvRating: Int? = nil,
		volumeCount: Int? = nil,
		chapterCount: Int? = nil,
		pageCount: Int? = nil
	) {
		self.publicationDay = publicationDay
		self.publicationSeason = publicationSeason
		self.publicationTime = publicationTime
		self.countryOfOrigin = countryOfOrigin
		self.duration = duration
		self.startedAt = startedAt
		self.endedAt = endedAt
		self.isNSFW = isNSFW
		self.mediaType = mediaType
		self.source = source
		self.status = status
		self.tvRating = tvRating
		self.volumeCount = volumeCount
		self.chapterCount = chapterCount
		self.pageCount = pageCount
	}
}

// MARK: - Filterable
extension LiteratureFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		return [
			"publication_day": self.publicationDay,
			"publication_season": self.publicationSeason,
			"publication_time": self.publicationTime,
			"country_id": self.countryOfOrigin,
			"duration": self.duration,
			"started_at": self.startedAt,
			"ended_at": self.endedAt,
			"is_nsfw": self.isNSFW,
			"media_type_id": self.mediaType,
			"source_id": self.source,
			"status_id": self.status,
			"tv_rating_id": self.tvRating,
			"volume_count": self.volumeCount,
			"chapter_count": self.chapterCount,
			"page_count": self.pageCount
		]
	}
}
