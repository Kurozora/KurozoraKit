//
//  UserRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 06/08/2020.
//  MIT License
//

import Foundation

extension User {
	/// A root object that stores information about user relationships, such as the access tokens that belong to it.
	public struct Relationships: Codable, Sendable {
		// MARK: - Properties
		/// The access tokens belonging to the user.
		public let accessTokens: ResourceCollection<AccessToken>?
	}
}
