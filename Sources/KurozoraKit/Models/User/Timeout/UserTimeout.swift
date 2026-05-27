//
//  UserTimeout.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a user timeout resource.
public struct UserTimeout: Codable, Sendable, Identifiable {
	// MARK: - Properties
	/// The identifier of the timeout.
	public let id: String

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the timeout.
	public let attributes: UserTimeout.Attributes

	/// The relationships belonging to the timeout.
	public let relationships: UserTimeout.Relationships?
}
