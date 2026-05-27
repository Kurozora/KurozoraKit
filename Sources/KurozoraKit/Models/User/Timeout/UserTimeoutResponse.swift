//
//  UserTimeoutResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a user timeout response.
public struct UserTimeoutResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a user timeout request.
	public let data: [UserTimeout]
}
