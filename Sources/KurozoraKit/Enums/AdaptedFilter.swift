//
//  AdaptedFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/08/2026.
//  MIT License
//

import Foundation

/// The set of filters used to narrow titles that have an anime adaptation.
public enum AdaptedFilter: Int, Codable, Sendable, CaseIterable {
	// MARK: - Cases
	/// Every title that has an anime adaptation.
	case all = 0

	/// Titles whose anime adaptation is currently airing.
	case airing = 1

	/// Titles whose anime adaptation is slated for a future date.
	case upcoming = 2

	// MARK: - Properties
	/// The string value of an adapted filter.
	public var stringValue: String {
		switch self {
		case .all:
			return "All"
		case .airing:
			return "Airing Now"
		case .upcoming:
			return "Upcoming Anime"
		}
	}
}
