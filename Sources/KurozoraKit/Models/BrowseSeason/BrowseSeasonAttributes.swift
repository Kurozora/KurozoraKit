//
//  BrowseSeasonAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

import Foundation

extension BrowseSeason {
	/// A root object that stores information about a single browse season, such as its media type.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The media type that groups the items in this section.
		public let type: MediaType
	}
}
