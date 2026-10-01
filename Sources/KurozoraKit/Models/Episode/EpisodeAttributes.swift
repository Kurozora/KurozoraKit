//
//  EpisodeAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//  MIT License
//

import Foundation

extension Episode {
	/// A root object that stores information about a single episode, such as the episodes's number, name, and air date.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The link to a poster image of the episode.
		public let poster: Media?

		/// The link to a banner image of the episode.
		public let banner: Media?

		/// The in season number of the episode.
		public let number: Int

		/// The total number of the episode.
		public let numberTotal: Int

		/// The number of the season.
		public let seasonNumber: Int

		/// The title of the episodes.
		public let title: String

		/// The synopsis text of the episode.
		public let synopsis: String?

		/// The show's tv rating.
		public let tvRating: TVRating?

		/// The title of the previous episode.
		public let previousEpisodeTitle: String?

		/// The title of the next episode.
		public let nextEpisodeTitle: String?

		/// The title of the show.
		public let showTitle: String

		/// The duration of the episode.
		public let duration: String

		/// The stats of the episode.
		public let stats: MediaStat?

		/// The air date of the episode.
		public let startedAt: Date?

		/// The view count of the episode.
		public let viewCount: Int

		/// The canon standing of the episode.
		public let fillerKind: EpisodeFillerKind

		/// Whether the episode details have been verified.
		public let isVerified: Bool
	}
}
