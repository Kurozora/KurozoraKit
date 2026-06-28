//
//  WeeklyDigestSectionAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

extension WeeklyDigestSection {
	/// A root object that stores information about a single weekly digest section, such as its kind, title, and momentum stats.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The kind of the section.
		public let kind: String

		/// The title of the section.
		public let title: String?

		/// The subtitle of the section.
		public let subtitle: String?

		/// The position of the section within the digest.
		public let position: Int

		/// The user's consumption stats.
		public let momentum: WeeklyDigest.Momentum?
	}
}
