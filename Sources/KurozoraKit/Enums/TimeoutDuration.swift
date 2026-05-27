//
//  TimeoutDuration.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/05/2026.
//  MIT License
//

import Foundation

/// The set of preset timeout durations available to moderators.
public enum TimeoutDuration: Int, Codable, Sendable, CaseIterable {
	// MARK: - Cases
	/// Indicates a one-hour suspension.
	case oneHour = 1

	/// Indicates a one-day suspension.
	case oneDay = 2

	/// Indicates a three-day suspension.
	case threeDays = 3

	/// Indicates a seven-day suspension.
	case sevenDays = 4

	/// Indicates a thirty-day suspension.
	case thirtyDays = 5

	/// Indicates a permanent suspension.
	case permanent = 6
}
