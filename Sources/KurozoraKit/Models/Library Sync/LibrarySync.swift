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

/// The data envelope of a library sync response, holding both the pagination
/// metadata and the per-row library entries.
public struct LibrarySyncData: Codable, Sendable {
	// MARK: - Properties
	/// The pagination metadata for this sync batch.
	public let attributes: LibrarySyncAttributes

	/// The relationships included in this sync batch.
	public let relationships: LibrarySyncRelationships
}

/// The pagination metadata returned in a library sync response.
public struct LibrarySyncAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The library kind this sync batch belongs to.
	public let kind: Int

	/// The server-side wall-clock at which this batch was assembled, in seconds
	/// since the Unix epoch.
	public let syncTime: Int

	/// Whether more rows remain past this batch.
	public let hasMore: Bool

	/// The number of rows past the requested cursor, including this batch.
	public let total: Int?

	/// The cursor to pass into the next sync call when ``hasMore`` is `true`.
	public let nextSince: SyncCursor?
}

/// The relationships envelope of a library sync response.
public struct LibrarySyncRelationships: Codable, Sendable {
	// MARK: - Properties
	/// The library entries included in this sync batch.
	public let libraries: [LibrarySyncEntry]
}

/// A single library entry as returned in a sync batch.
public struct LibrarySyncEntry: Codable, Sendable {
	// MARK: - Properties
	/// The library entry's primary identifier.
	public let id: String

	/// The identifier of the trackable model the entry points at (anime/manga/game).
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

	/// The timestamp at which the entry was soft-deleted, or `nil` for live rows.
	public let deletedAt: Int?

	/// Whether the authenticated user has favorited the trackable.
	public let isFavorited: Bool

	/// The timestamp at which the user favorited the trackable, or `nil` if not favorited.
	public let favoritedAt: Int?

	/// Whether the authenticated user has set a reminder on the trackable.
	public let isReminded: Bool

	/// The timestamp at which the user set the reminder, or `nil` if no reminder is active.
	public let remindedAt: Int?

	/// The authenticated user's review of the trackable, or `nil` if no review exists.
	public let review: LibrarySyncReviewEntry?

	/// The trackable's URL-safe slug, used to build canonical webpage links.
	public let slug: String?

	/// The renderable title for the trackable, localised to the request's locale.
	public let title: String?

	/// The locale-stable sort key for alphabetical ordering.
	public let sortTitle: String?

	/// The trackable's tagline, or `nil` if absent.
	public let tagline: String?

	/// The poster image URL, or `nil` if no poster exists.
	public let posterURL: String?

	/// The poster placeholder background color as a hex string.
	public let posterBackgroundColor: String?

	/// The banner image URL, or `nil` if no banner exists.
	public let bannerURL: String?

	/// The banner placeholder background color as a hex string.
	public let bannerBackgroundColor: String?

	/// The trackable's genres pre-joined into a localised display string.
	public let genresLocalized: String?

	/// The trackable's status name (e.g. "Currently Airing"), localised.
	public let statusName: String?

	/// The next broadcast or publication timestamp in seconds since the Unix epoch.
	public let airingDate: Int?

	/// The countdown duration in seconds.
	public let durationCount: Int?

	/// The localised media-type label (e.g. "TV", "Movie", "Novel").
	public let mediaTypeName: String?

	/// The popularity ranking of the trackable; lower is more popular.
	public let popularityRank: Int?

	/// The public average rating used for the rating sort axis.
	public let publicRating: Double?
}

/// The authenticated user's review attached to a library entry.
public struct LibrarySyncReviewEntry: Codable, Sendable {
	// MARK: - Properties
	/// The media-rating row's primary identifier.
	public let id: String

	/// The numeric score the user assigned, from `0` to `5`.
	public let score: Double

	/// The optional written review accompanying the score.
	public let description: String?

	/// The timestamp at which the review was first created.
	public let createdAt: Int?

	/// The timestamp at which the review was last edited.
	public let updatedAt: Int?
}
