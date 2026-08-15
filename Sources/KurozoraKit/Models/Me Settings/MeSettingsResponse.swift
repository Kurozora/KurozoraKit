//
//  MeSettingsResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about an authenticated user's settings collection response.
public struct MeSettingsResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for an authenticated user's settings request.
	public let data: [MeSettings]
}
