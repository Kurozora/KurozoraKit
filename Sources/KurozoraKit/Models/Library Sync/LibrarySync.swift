//
//  LibrarySync.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response to a library sync request.
public struct LibrarySyncResponse: Codable, Sendable {
	// MARK: - Properties
	/// The sync envelope returned by the server.
	public let data: LibrarySyncData
}

/// The data envelope of a library sync response.
public struct LibrarySyncData: Codable, Sendable {
	// MARK: - Properties
	/// The per-stream metadata for this sync round.
	public let attributes: LibrarySyncAttributes

	/// The rows included in this sync round.
	public let relationships: LibrarySyncRelationships
}

/// The metadata returned in a library sync response.
public struct LibrarySyncAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The server-side wall-clock at which this round was assembled.
	public let syncTime: Int

	/// The state of each cursored stream.
	private let streams: [String: LibrarySyncStreamState]

	// MARK: - Functions
	/// The state the server reported for the given stream.
	///
	/// - Parameter stream: The stream to look up.
	///
	/// - Returns: The stream's state.
	public func state(of stream: LibrarySyncStream) -> LibrarySyncStreamState? {
		return self.streams[stream.rawValue]
	}
}

/// The state of a single cursored stream within a sync round.
public struct LibrarySyncStreamState: Codable, Sendable {
	// MARK: - Properties
	/// Whether more rows remain past this round.
	public let hasMore: Bool

	/// The number of rows past the requested cursor.
	public let total: Int?

	/// The cursor to pass into the next sync call.
	public let nextSince: SyncCursor?
}

/// The relationships envelope of a library sync response.
public struct LibrarySyncRelationships: Codable, Sendable {
	// MARK: - Properties
	/// The library entries included in this round.
	public let entries: [LibrarySyncEntry]

	/// The trackables included in this round.
	public let trackables: [LibrarySyncTrackable]

	/// The episodes inside the reminder window.
	public let episodes: [LibrarySyncEpisode]
}

/// A single library entry as returned in a sync round.
public struct LibrarySyncEntry: Codable, Sendable {
	// MARK: - Properties
	/// The library entry's primary identifier.
	public let id: String

	/// The raw value of the library kind the entry belongs to.
	public let kind: Int

	/// The identifier of the trackable model the entry points at.
	public let trackableID: String

	/// The library status assigned to the entry.
	public let status: Int

	/// The number of times the user has rewatched the trackable.
	public let rewatchCount: Int

	/// Whether the entry is hidden from public views of the user's library.
	public let isHidden: Bool

	/// The timestamp at which the user started consuming the trackable.
	public let startedAt: Int?

	/// The timestamp at which the user finished consuming the trackable.
	public let endedAt: Int?

	/// The timestamp at which the entry was first created.
	public let createdAt: Int?

	/// The timestamp at which the entry was last touched.
	public let updatedAt: Int?

	/// The timestamp at which the entry was soft-deleted.
	public let deletedAt: Int?

	/// Whether the authenticated user has favorited the trackable.
	public let isFavorited: Bool

	/// The timestamp at which the user favorited the trackable.
	public let favoritedAt: Int?

	/// Whether the authenticated user has set a reminder on the trackable.
	public let isReminded: Bool

	/// The timestamp at which the user set the reminder.
	public let remindedAt: Int?

	/// The authenticated user's review of the trackable.
	public let review: LibrarySyncReviewEntry?
}

/// A single catalog model as returned in a sync round.
public struct LibrarySyncTrackable: Codable, Sendable {
	// MARK: - Properties
	/// The trackable's primary identifier.
	public let id: String

	/// The raw value of the library kind the trackable belongs to.
	public let kind: Int

	/// The trackable's URL-safe slug.
	public let slug: String?

	/// The renderable title for the trackable.
	public let title: String?

	/// The locale-stable sort key for alphabetical ordering.
	public let sortTitle: String?

	/// The trackable's tagline.
	public let tagline: String?

	/// The poster image URL.
	public let posterURL: String?

	/// The poster placeholder background color as a hex string.
	public let posterBackgroundColor: String?

	/// The banner image URL.
	public let bannerURL: String?

	/// The banner placeholder background color as a hex string.
	public let bannerBackgroundColor: String?

	/// The trackable's genres pre-joined into a localized display string.
	public let genresLocalized: String?

	/// The identifier of the trackable's media type.
	public let mediaTypeID: Int?

	/// The localized media-type label.
	public let mediaTypeName: String?

	/// The identifier of the trackable's airing or publishing status.
	public let statusID: Int?

	/// The trackable's localized status name.
	public let statusName: String?

	/// The next broadcast or publication timestamp in seconds since the Unix epoch.
	public let airingDate: Int?

	/// The countdown duration in seconds.
	public let durationCount: Int?

	/// The popularity ranking of the trackable.
	public let popularityRank: Int?

	/// The public average rating used for the rating sort axis.
	public let publicRating: Double?

	/// The identifier of the trackable's TV rating.
	public let tvRatingID: Int?

	/// The identifier of the trackable's adaptation source.
	public let sourceID: Int?

	/// The two-letter code of the trackable's country of origin.
	public let countryOfOrigin: String?

	/// Whether the trackable is marked not safe for work.
	public let isNSFW: Bool?

	/// The weekday the trackable airs or publishes on.
	public let scheduleDay: Int?

	/// The season of the year the trackable airs or publishes in.
	public let scheduleSeason: Int?

	/// The number of episodes, chapters or editions the trackable has.
	public let episodeCount: Int?

	/// The number of seasons or volumes the trackable has.
	public let seasonCount: Int?

	/// The date the trackable first aired or published.
	public let firstAired: Int?

	/// The date the trackable last aired or published.
	public let lastAired: Int?
}

/// An episode inside the reminder window.
public struct LibrarySyncEpisode: Codable, Sendable {
	// MARK: - Properties
	/// The episode's primary identifier.
	public let id: String

	/// The identifier of the show the episode belongs to.
	public let trackableID: String

	/// The number of the episode within its show.
	public let numberTotal: Int

	/// The number of the episode within its season.
	public let number: Int

	/// The number of the season the episode belongs to.
	public let seasonNumber: Int

	/// The date the episode airs.
	public let startedAt: Int?

	/// The URL of the episode's banner.
	public let bannerURL: String?
}

/// The authenticated user's review attached to a library entry.
public struct LibrarySyncReviewEntry: Codable, Sendable {
	// MARK: - Properties
	/// The media-rating row's primary identifier.
	public let id: String

	/// The numeric score the user assigned.
	public let score: Double

	/// The written review accompanying the score.
	public let description: String?

	/// Whether the review contains a spoiler.
	public let isSpoiler: Bool

	/// The reviewer's recommendation.
	public let recommendation: ReviewRecommendation?

	/// The timestamp at which the review was first created.
	public let createdAt: Int?

	/// The timestamp at which the review was last edited.
	public let updatedAt: Int?
}
