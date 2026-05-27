//
//  UserTimeoutRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/05/2026.
//  MIT License
//

import Foundation

public extension UserTimeout {
	/// A root object that stores information about user timeout relationships, such as the appeal filed against it.
	struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The appeal filed against the timeout.
		public let appeal: ResourceCollection<UserTimeoutAppeal>?
	}
}
