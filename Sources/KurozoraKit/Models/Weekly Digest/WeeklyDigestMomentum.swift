//
//  WeeklyDigestMomentum.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

extension WeeklyDigest {
	/// A root object that stores the user's consumption stats for the week.
	public struct Momentum: Codable, Sendable {
		// MARK: - Properties
		/// The number of episodes the user watched this week.
		public let episodesWatched: Int

		/// The total number of seconds the user watched this week.
		public let secondsWatched: Int

		/// The number of titles the user finished this week.
		public let finishedCount: Int

		/// The user's lifetime watched-episode count.
		public let lifetimeEpisodes: Int

		/// The next watched-episode milestone the user is working towards.
		public let nextMilestone: Int

		/// The number of episodes remaining until the next milestone.
		public let episodesToMilestone: Int

		/// The number of consecutive recent weeks the user has logged an episode.
		public let weekStreak: Int

		/// Whether the user watched anything worth celebrating this week.
		public let hasMomentum: Bool
	}
}
