//
//  FilterValue.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

import Foundation

/// The value a single filter attribute carries.
public enum FilterValue: Hashable, Sendable {
	// MARK: - Cases
	/// Indicates a tri-state selection over numeric options.
	case selection(FilterSelection<Int>)

	/// Indicates a tri-state selection over textual options.
	case textSelection(FilterSelection<String>)

	/// Indicates a bounded range of numbers.
	case range(FilterRange)

	/// Indicates a yes or no choice.
	case boolean(Bool)

	/// Indicates a point in time in seconds since 1970.
	case date(TimeInterval)

	/// Indicates free text.
	case text(String)

	// MARK: - Properties
	/// Whether the value narrows the results.
	public var isEmpty: Bool {
		switch self {
		case .selection(let selection): return selection.isEmpty
		case .textSelection(let selection): return selection.isEmpty
		case .range(let range): return range.isEmpty
		case .boolean: return false
		case .date: return false
		case .text(let text): return text.isEmpty
		}
	}

	/// The value as the API expects it.
	public var filterValue: Any? {
		switch self {
		case .selection(let selection): return selection.filterValue
		case .textSelection(let selection): return selection.filterValue
		case .range(let range): return range.filterValue
		case .boolean(let boolean): return boolean
		case .date(let date): return date
		case .text(let text): return text.isEmpty ? nil : text
		}
	}
}
