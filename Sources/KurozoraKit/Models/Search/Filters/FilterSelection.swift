//
//  FilterSelection.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

/// A set of filter values to keep and a set to leave out.
public struct FilterSelection<Value: Hashable & Comparable & Sendable>: Hashable, Sendable {
	// MARK: - Properties
	/// The values a result matches on.
	public let included: Set<Value>

	/// The values a result is rejected for.
	public let excluded: Set<Value>

	/// Whether the selection narrows the results.
	public var isEmpty: Bool {
		return self.included.isEmpty && self.excluded.isEmpty
	}

	/// The selection as the API expects it.
	public var filterValue: [String: [Value]]? {
		guard !self.isEmpty else { return nil }

		var filterValue: [String: [Value]] = [:]

		if !self.included.isEmpty {
			filterValue["include"] = self.included.sorted()
		}

		if !self.excluded.isEmpty {
			filterValue["exclude"] = self.excluded.sorted()
		}

		return filterValue
	}

	// MARK: - Initializers
	/// Creates a selection from the given values.
	///
	/// - Parameters:
	///    - included: The values a result matches on.
	///    - excluded: The values a result is rejected for.
	public init(included: Set<Value> = [], excluded: Set<Value> = []) {
		self.included = included
		self.excluded = excluded
	}

	/// Creates a selection holding a single included value.
	///
	/// - Parameter value: The value a result matches on.
	public init(_ value: Value) {
		self.included = [value]
		self.excluded = []
	}

	// MARK: - Functions
	/// Returns the selection with the given value moved to its next state.
	///
	/// - Parameter value: The value the user tapped.
	///
	/// - Returns: The selection the tap produces.
	public func cycling(_ value: Value) -> Self {
		var included = self.included
		var excluded = self.excluded

		if included.remove(value) != nil {
			excluded.insert(value)
		} else if excluded.remove(value) == nil {
			included.insert(value)
		}

		return Self(included: included, excluded: excluded)
	}

	/// Returns the state the given value is in.
	///
	/// - Parameter value: The value to read.
	///
	/// - Returns: The value's state.
	public func state(of value: Value) -> FilterSelectionState {
		if self.included.contains(value) {
			return .included
		}

		if self.excluded.contains(value) {
			return .excluded
		}

		return .neutral
	}
}
