//
//  LibraryKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/03/2019.
//  MIT License
//

import Foundation

/// The set of available library types.
public enum LibraryKind: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// The shows library of the user.
	case shows = 0

	/// The literature library of the user.
	case literatures = 1

	/// The games library of the user.
	case games = 2

	// MARK: - Properties
	/// The string value of a library type.
	public var stringValue: String {
		switch self {
		case .shows:
			return "Shows"
		case .literatures:
			return "Literatures"
		case .games:
			return "Games"
		}
	}
}

/// The set of available library status types.
public enum LibraryStatus: Int, Codable, Sendable {
	// MARK: - Cases
	/// The library has no status.
	case none = -1

	/// The library's watching list.
	case inProgress = 0

	/// The library's planning list.
	case planning = 2

	/// The library's completed list.
	case completed = 3

	/// The library's on-hold list.
	case onHold = 4

	/// The library's dropped list.
	case dropped = 1

	/// The library's interested list.
	case interested = 6

	/// The library's ignored list.
	case ignored = 5

	// MARK: - Properties
	/// An array containing all library status types.
	public static let all: [LibraryStatus] = [.inProgress, .planning, .completed, .onHold, .dropped, .interested, .ignored]

	/// The string value of a library status type.
	public var stringValue: String {
		switch self {
		case .none:
			return "None"
		case .inProgress:
			return "In Progress"
		case .planning:
			return "Planning"
		case .completed:
			return "Completed"
		case .onHold:
			return "On-Hold"
		case .dropped:
			return "Dropped"
		case .interested:
			return "Interested"
		case .ignored:
			return "Ignored"
		}
	}

	/// The section value string of a library status type.
	public var sectionValue: String {
		switch self {
		case .inProgress:
			return "InProgress"
		case .onHold:
			return "OnHold"
		default:
			return self.stringValue
		}
	}
}

/// The set of available library sorting types.
public enum LibrarySortType: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// Sorted by no specific type.
	case none = 0

	/// Sorted by alphabetical order.
	case alphabetically

	/// Sorted by popularity.
	case popularity

	/// Sorted by date.
	case date

	/// Sorted by global rating.
	case rating

	/// Sorted by user's rating.
	case myRating

	// MARK: - Properties
	/// An array containing all sort types.
	public static let all: [LibrarySortType] = [.alphabetically, .popularity, .date, .rating, .myRating]

	/// The string value of a sort type.
	public var stringValue: String {
		switch self {
		case .none:
			return "None"
		case .alphabetically:
			return "Alphabetically"
		case .popularity:
			return "Popularity"
		case .date:
			return "Date"
		case .rating:
			return "Rating"
		case .myRating:
			return "My Rating"
		}
	}

	/// The parameter value of a sort type.
	public var parameterValue: String {
		switch self {
		case .none:
			return ""
		case .alphabetically:
			return "title"
		case .popularity:
			return "popularity"
		case .date:
			return "date"
		case .rating:
			return "rating"
		case .myRating:
			return "my-rating"
		}
	}

	/// The available sort options for this sort type.
	public var optionValue: [LibrarySortOption] {
		switch self {
		case .none:
			return []
		case .alphabetically:
			return [.ascending, .descending]
		case .popularity:
			return [.most, .least]
		case .date:
			return [.newest, .oldest]
		case .rating:
			return [.best, .worst]
		case .myRating:
			return [.best, .worst]
		}
	}
}

/// The set of available library sort option types.
public enum LibrarySortOption: Int, Sendable {
	// MARK: - Cases
	/// Sorted by no options.
	case none = 0

	/// Sorted in ascending order.
	case ascending

	/// Sorted in descending order.
	case descending

	/// Sorted by most first.
	case most

	/// Sorted by least first.
	case least

	/// Sorted by newest first.
	case newest

	/// Sorted by oldest first.
	case oldest

	/// Sorted by worst first.
	case worst

	/// Sorted by best first.
	case best

	// MARK: - Properties
	/// An array containing all sort type option types.
	public static let all: [LibrarySortOption] = [.ascending, .descending, .newest, .oldest, .worst, .best]

	/// The string value of a sort type option.
	public var stringValue: String {
		switch self {
		case .none:
			return "None"
		case .ascending:
			return "A-Z"
		case .descending:
			return "Z-A"
		case .most:
			return "Most"
		case .least:
			return "Least"
		case .newest:
			return "Newest"
		case .oldest:
			return "Oldest"
		case .worst:
			return "Worst"
		case .best:
			return "Best"
		}
	}

	/// The parameter value of a sort type option.
	public var parameterValue: String {
		switch self {
		case .none:
			return "()"
		case .ascending:
			return "(asc)"
		case .descending:
			return "(desc)"
		case .most:
			return "(most)"
		case .least:
			return "(least)"
		case .newest:
			return "(newest)"
		case .oldest:
			return "(oldest)"
		case .best:
			return "(best)"
		case .worst:
			return "(worst)"
		}
	}
}
