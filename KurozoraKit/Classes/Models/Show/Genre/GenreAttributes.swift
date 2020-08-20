//
//  GenreAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//

extension Genre {
	/**
		A root object that stores information about a single genre, such as the genre's name, color, and symbol.
	*/
	public struct Attributes: Codable {
		// MARK: - Properties
		/// The name of the genre.
		public let name: String

		/// The description of the genre.
		public let description: String?

		/// The color of the genre.
		public let color: String

		/// The link to the symbol of the genre.
		public let symbol: String?

		/// Whether the genre is Not Safe For Work.
		public let isNSFW: Bool
	}
}