//
//  EditorialAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

extension Editorial {
	/// A root object that stores information about a single editorial, such as its body, and byline.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The body of the editorial.
		public let body: String

		/// The byline of the editorial.
		public let byline: String?

		/// The publish date of the editorial.
		public let publishedAt: Date?
	}
}
