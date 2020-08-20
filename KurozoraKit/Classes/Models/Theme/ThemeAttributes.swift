//
//  ThemeAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//

extension Theme {
	/**
		A root object that stores information about a single theme, such as the theme's name, download count, and download link.
	*/
	public struct Attributes: Codable {
		// MARK: - Properties
		/// The name of the theme.
		public let name: String

		/// The background color of the theme.
		public let backgroundColor: String?

		/// The download count of the theme.
		public let downloadCount: Int?

		/// The download link of the theme.
		public let downloadLink: String

		/// The link to a screenshot of the theme.
		public let screenshot: String

//		/// The current user's information regarding the theme.
//		public let currentUser: UserProfile?
	}
}