//
//  FilterRange.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/09/2026.
//  MIT License
//

/// A bounded range of numeric filter values.
public struct FilterRange: Hashable, Sendable {
	// MARK: - Properties
	/// The lowest value a result may hold.
	public let minimum: Int?

	/// The highest value a result may hold.
	public let maximum: Int?

	/// Whether the range narrows the results.
	public var isEmpty: Bool {
		return self.minimum == nil && self.maximum == nil
	}

	/// The range as the API expects it.
	public var filterValue: [String: Int]? {
		guard !self.isEmpty else { return nil }

		var filterValue: [String: Int] = [:]

		if let minimum = self.minimum {
			filterValue["from"] = minimum
		}

		if let maximum = self.maximum {
			filterValue["to"] = maximum
		}

		return filterValue
	}

	// MARK: - Initializers
	/// Creates a range from the given bounds.
	///
	/// - Parameters:
	///    - minimum: The lowest value a result may hold.
	///    - maximum: The highest value a result may hold.
	public init(minimum: Int? = nil, maximum: Int? = nil) {
		self.minimum = minimum
		self.maximum = maximum
	}

	// MARK: - Functions
	/// Whether the given value falls inside the range.
	///
	/// - Parameter value: The value to test.
	///
	/// - Returns: `true` when the value sits within both bounds.
	public func contains(_ value: Int) -> Bool {
		if let minimum = self.minimum, value < minimum {
			return false
		}

		if let maximum = self.maximum, value > maximum {
			return false
		}

		return true
	}
}
