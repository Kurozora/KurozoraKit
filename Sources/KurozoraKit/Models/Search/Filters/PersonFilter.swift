//
//  PersonFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying people.
public struct PersonFilter {
	// MARK: - Properties
	/// The astrological sign identifier to filter by.
	public let astrologicalSign: Int?

	/// The birth date to filter by, expressed as a time interval since the reference date.
	public let birthDate: TimeInterval?

	/// The deceased date to filter by, expressed as a time interval since the reference date.
	public let deceasedDate: TimeInterval?

	// MARK: - Initializers
	public init(astrologicalSign: Int? = nil, birthDate: TimeInterval? = nil, deceasedDate: TimeInterval? = nil) {
		self.astrologicalSign = astrologicalSign
		self.birthDate = birthDate
		self.deceasedDate = deceasedDate
	}
}

// MARK: - Filterable
extension PersonFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		return [
			"astrological_sign": self.astrologicalSign,
			"birthdate": self.birthDate,
			"deceased_date": self.deceasedDate
		]
	}
}
