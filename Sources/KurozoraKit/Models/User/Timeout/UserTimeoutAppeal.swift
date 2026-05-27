//
//  UserTimeoutAppeal.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a user timeout appeal resource.
public struct UserTimeoutAppeal: Codable, Sendable, Identifiable {
	// MARK: - Properties
	/// The identifier of the appeal.
	public let id: String

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the appeal.
	public let attributes: UserTimeoutAppeal.Attributes
}
