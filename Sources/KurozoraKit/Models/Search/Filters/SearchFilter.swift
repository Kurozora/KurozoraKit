//
//  SearchFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

/// The filter attached to a search request.
public struct SearchFilter: Hashable, Sendable {
	// MARK: - Properties
	/// The resource the filter applies to.
	public let type: SearchType

	/// The value held against each attribute.
	public let values: [FilterKey: FilterValue]

	/// Whether the filter narrows the results.
	public var isEmpty: Bool {
		return self.values.allSatisfy { _, value in
			value.isEmpty
		}
	}

	// MARK: - Initializers
	/// Creates a filter for the given resource.
	///
	/// - Parameters:
	///    - type: The resource the filter applies to.
	///    - values: The value held against each attribute.
	public init(type: SearchType, values: [FilterKey: FilterValue] = [:]) {
		self.type = type
		self.values = values
	}

	// MARK: - Functions
	/// Returns the value held against the given attribute.
	///
	/// - Parameter key: The attribute to read.
	///
	/// - Returns: The attribute's value.
	public subscript(key: FilterKey) -> FilterValue? {
		return self.values[key]
	}

	/// Returns the filter with the given attribute set.
	///
	/// - Parameters:
	///    - value: The value to hold against the attribute.
	///    - key: The attribute to write.
	///
	/// - Returns: The filter carrying the new value.
	public func setting(_ value: FilterValue?, for key: FilterKey) -> Self {
		var values = self.values
		values[key] = value

		return Self(type: self.type, values: values)
	}
}

// MARK: - Filterable
extension SearchFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		var filterArray: [String: Any?] = [:]

		for (key, value) in self.values where !value.isEmpty {
			filterArray[key.apiKey(for: self.type)] = value.filterValue
		}

		return filterArray
	}
}
