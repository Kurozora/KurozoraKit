//
//  ProviderAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

extension Provider {
	/// The attributes of a provider.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The slug of the provider.
		public let slug: String

		/// The name of the provider.
		public let name: String

		/// The alternative names of the provider.
		public let alternativeNames: [String]?

		/// The website of the provider.
		public let url: String?

		/// The logo of the provider.
		public let logo: Media?

		/// Whether the provider is public.
		public let isPublic: Bool
	}
}
