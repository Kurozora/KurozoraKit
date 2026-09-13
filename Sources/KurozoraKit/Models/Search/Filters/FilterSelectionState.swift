//
//  FilterSelectionState.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

/// The states a filter value cycles through.
public enum FilterSelectionState: Sendable {
	/// Indicates the value does not take part in the filter.
	case neutral

	/// Indicates a result matches on the value.
	case included

	/// Indicates a result is rejected for the value.
	case excluded
}
