//
//  UserTimeoutAppealAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/05/2026.
//  MIT License
//

import Foundation

public extension UserTimeoutAppeal {
	/// A root object that stores information about a single timeout appeal, such as the message and the dates it was filed and updated.
	struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The user-authored appeal message.
		public let message: String

		/// The date at which the appeal was filed.
		public let createdAt: Date

		/// The date at which the appeal was last updated.
		public let updatedAt: Date
	}
}
