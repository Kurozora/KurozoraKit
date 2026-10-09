//
//  ReviewSortType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 10/10/2026.
//  MIT License
//

import Foundation

/// The set of available review sorting types.
public enum ReviewSortType: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// Sorted by the date of the review.
	case date = 0

	/// Sorted by the title of the reviewed item.
	case title = 1

	/// Sorted by the rating of the review.
	case rating = 2

	// MARK: - Properties
	/// The parameter value of a sort type.
	public var parameterValue: String {
		switch self {
		case .date:
			return "date"
		case .title:
			return "title"
		case .rating:
			return "rating"
		}
	}

	/// The available sort options for this sort type.
	public var optionValue: [ReviewSortOption] {
		switch self {
		case .date:
			return [.newest, .oldest]
		case .title:
			return [.ascending, .descending]
		case .rating:
			return [.best, .worst]
		}
	}
}
