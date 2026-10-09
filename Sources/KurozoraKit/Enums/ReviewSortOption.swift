//
//  ReviewSortOption.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 10/10/2026.
//  MIT License
//

import Foundation

/// The set of available review sort option types.
public enum ReviewSortOption: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// Sorted by newest first.
	case newest = 0

	/// Sorted by oldest first.
	case oldest = 1

	/// Sorted in ascending order.
	case ascending = 2

	/// Sorted in descending order.
	case descending = 3

	/// Sorted by best first.
	case best = 4

	/// Sorted by worst first.
	case worst = 5

	// MARK: - Properties
	/// The parameter value of a sort option.
	public var parameterValue: String {
		switch self {
		case .newest:
			return "(newest)"
		case .oldest:
			return "(oldest)"
		case .ascending:
			return "(asc)"
		case .descending:
			return "(desc)"
		case .best:
			return "(best)"
		case .worst:
			return "(worst)"
		}
	}
}
