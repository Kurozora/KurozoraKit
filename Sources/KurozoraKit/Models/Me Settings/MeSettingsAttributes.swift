//
//  MeSettingsAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

extension MeSettings {
	/// A root object that stores information about the authenticated user's settings, such as the user's preferred rating style.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The percentage of a media that must be played before it is scrobbled.
		public var scrobbleThreshold: Int

		/// Whether the user's Discord rich presence is enabled.
		public var discordRichPresenceEnabled: Bool

		/// The image shown in the user's Discord rich presence.
		public var discordPresenceImage: Int

		/// The activity name shown in the user's Discord rich presence.
		public var discordActivityName: Int

		/// The style used to rate and review media.
		public var ratingStyle: RatingStyle
	}
}
