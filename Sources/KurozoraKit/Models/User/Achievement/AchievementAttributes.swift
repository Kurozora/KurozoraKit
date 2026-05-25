//
//  AchievementAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//  MIT License
//

import Foundation

extension Achievement {
	/// A root object that stores information about a single achievement, such as the achievement's name, description, and color.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The name of the achievement.
		public let name: String

		/// The description of the achievement.
		public let description: String

		/// The media object of the symbol of the achievement.
		public let symbol: Media?

		/// The date on which the user unlocked the achievement.
		public let achievedAt: Date?
	}
}
