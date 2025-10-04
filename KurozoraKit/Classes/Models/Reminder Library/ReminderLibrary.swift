//
//  ReminderLibrary.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 11/07/2024.
//

import Foundation

/// A root object that stores information about a reminder library resource.
public struct ReminderLibrary: Codable, Sendable {
	// MARK: - Properties
	/// A collection of games.
	public let games: [Game]?

	/// A collection of literatures.
	public let literatures: [Literature]?

	/// A collection of shows.
	public let shows: [Show]?
}
