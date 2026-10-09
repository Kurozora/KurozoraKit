//
//  FilterKey.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

/// The attributes a search or list can be filtered on.
public enum FilterKey: String, CaseIterable, Hashable, Sendable {
	// MARK: - Cases
	case age
	case astrologicalSign
	case birthDay
	case birthMonth
	case bust
	case height
	case hip
	case status
	case waist
	case weight

	case countryOfOrigin
	case duration
	case fillerKind
	case isNSFW
	case isSpecial
	case isPremiere
	case isFinale
	case isVerified
	case number
	case numberTotal
	case season
	case tvRating
	case startedAt
	case endedAt

	case publicationDay
	case publicationSeason
	case publishedAt
	case mediaType
	case source
	case editionCount

	case publicationTime
	case volumeCount
	case chapterCount
	case pageCount

	case birthDate
	case deceasedDate

	case airDay
	case airSeason
	case airTime
	case seasonCount
	case episodeCount

	case address
	case foundedAt
	case defunctAt
	case type

	case downloadCount
	case name
	case uiStatusBarStyle
	case version

	case hasReview
	case rating

	// MARK: - Functions
	/// The name the API gives the attribute.
	///
	/// - Parameter searchType: The resource the filter applies to.
	///
	/// - Returns: The API's name for the attribute.
	public func apiKey(for searchType: SearchType) -> String {
		switch self {
		case .age: return "age"
		case .astrologicalSign: return "astrological_sign"
		case .birthDay: return "birth_day"
		case .birthMonth: return "birth_month"
		case .bust: return "bust"
		case .height: return "height"
		case .hip: return "hip"
		case .status: return searchType == .characters ? "status" : "status_id"
		case .waist: return "waist"
		case .weight: return "weight"
		case .countryOfOrigin: return "country_id"
		case .duration: return "duration"
		case .fillerKind: return "filler_kind"
		case .isNSFW: return "is_nsfw"
		case .isSpecial: return "is_special"
		case .isPremiere: return "is_premiere"
		case .isFinale: return "is_finale"
		case .isVerified: return "is_verified"
		case .number: return "number"
		case .numberTotal: return "number_total"
		case .season: return "season_id"
		case .tvRating: return "tv_rating_id"
		case .startedAt: return "started_at"
		case .endedAt: return "ended_at"
		case .publicationDay: return "publication_day"
		case .publicationSeason: return "publication_season"
		case .publishedAt: return "published_at"
		case .mediaType: return "media_type_id"
		case .source: return "source_id"
		case .editionCount: return "edition_count"
		case .publicationTime: return "publication_time_part"
		case .volumeCount: return "volume_count"
		case .chapterCount: return "chapter_count"
		case .pageCount: return "page_count"
		case .birthDate: return "birthdate"
		case .deceasedDate: return "deceased_date"
		case .airDay: return "air_day"
		case .airSeason: return "air_season"
		case .airTime: return "air_time_part"
		case .seasonCount: return "season_count"
		case .episodeCount: return "episode_count"
		case .address: return "address"
		case .foundedAt: return "founded_at"
		case .defunctAt: return "defunct_at"
		case .type: return "type"
		case .downloadCount: return "download_count"
		case .name: return "name"
		case .uiStatusBarStyle: return "ui_status_bar_style"
		case .version: return "version"
		case .hasReview: return "has_review"
		case .rating: return "rating"
		}
	}
}
