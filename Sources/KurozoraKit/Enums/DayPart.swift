//
//  DayPart.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

import Foundation

/// The parts a broadcast day is divided into.
public enum DayPart: Int, CaseIterable, Hashable, Sendable {
	// MARK: - Cases
	/// Indicates the hours around midnight.
	case lateNight = 0

	/// Indicates the hours before noon.
	case morning

	/// Indicates the hours after noon.
	case afternoon

	/// Indicates the hours before midnight.
	case evening

	// MARK: - Properties
	/// The hour the day part starts at.
	public var startHour: Int {
		switch self {
		case .lateNight: return 23
		case .morning: return 6
		case .afternoon: return 12
		case .evening: return 18
		}
	}

	/// The hour the day part ends at.
	public var endHour: Int {
		switch self {
		case .lateNight: return 6
		case .morning: return 12
		case .afternoon: return 18
		case .evening: return 23
		}
	}

	// MARK: - Functions
	/// Whether the given hour falls inside the day part.
	///
	/// - Parameter hour: The hour to test.
	///
	/// - Returns: `true` when the hour sits within the bounds.
	public func contains(hour: Int) -> Bool {
		if self.startHour > self.endHour {
			return hour >= self.startHour || hour < self.endHour
		}

		return hour >= self.startHour && hour < self.endHour
	}
}
