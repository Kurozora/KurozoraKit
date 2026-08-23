//
//  Trailer.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a trailer resource.
///
/// A trailer always belongs to a title, so `Parent` is the identity of whichever kind the
/// endpoint returns.
public struct Trailer<Parent: Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The unique identifier of the trailer.
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the trailer.
	public let attributes: Attributes

	/// The relationships belonging to the trailer.
	public let relationships: Relationships?

	// MARK: - Accessors
	/// The identity of the title the trailer belongs to.
	public var parent: Parent? {
		self.relationships?.parent.data.first
	}

	// MARK: - Attributes
	/// A root object that stores information about a trailer's attributes.
	public struct Attributes: Codable, Hashable, Sendable {
		/// The identifier of the video at its source.
		public let code: String

		/// The service hosting the video.
		public let source: String?

		/// The link the video is watched at.
		public let url: String

		/// Whether the video is subtitled.
		public let isSub: Bool

		/// Whether the video is dubbed.
		public let isDub: Bool

		/// The kind of promo the video is.
		public let type: String

		/// The date the video was published.
		public let publishedAt: Date?

		/// The number of times the video has been viewed.
		public let viewCount: Int
	}

	// MARK: - Relationships
	/// A root object that stores information about a trailer's relationships.
	public struct Relationships: Codable, Hashable, Sendable {
		/// The title the trailer belongs to.
		public let parent: Container

		/// A root object that stores the titles a relationship holds.
		public struct Container: Codable, Hashable, Sendable {
			/// The titles the relationship holds.
			public let data: [Parent]
		}
	}
}
