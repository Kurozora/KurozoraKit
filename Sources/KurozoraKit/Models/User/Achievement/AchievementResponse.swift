//
//  AchievementResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/08/2020.
//  MIT License
//

import Foundation

/// A root object that stores information about a collection of achievements.
public struct AchievementResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for an achievement object request.
	public let data: [Achievement]
}
