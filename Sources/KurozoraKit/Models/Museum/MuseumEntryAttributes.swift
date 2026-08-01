//
//  MuseumEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/08/2026.
//  MIT License
//

import Foundation

extension MuseumEntry {
	/// A root object that stores information about a single museum entry, such as the entry's title.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The title of the museum entry.
		public let title: String?

		/// The poster of the museum entry.
		public let poster: Media?
	}
}
