//
//  UserTimeoutAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

public extension UserTimeout {
	/// A root object that stores information about a single user timeout, such as the reason and the expiry.
	struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The reason key the timeout was issued for.
		public let reasonKey: TimeoutReason

		/// The localized label of the reason the timeout was issued for.
		public let reasonLabel: String

		/// The internal note attached to the timeout.
		public let note: String?

		/// Whether the timeout is permanent.
		public let isPermanent: Bool

		/// The date at which the timeout expires.
		public let expiresAt: Date?

		/// The date at which the timeout was issued.
		public let issuedAt: Date

		/// The URL of the community guidelines.
		public let communityGuidelinesURL: String
	}
}
