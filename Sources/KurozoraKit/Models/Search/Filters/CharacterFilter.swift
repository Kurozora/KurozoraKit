//
//  CharacterFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying characters.
public struct CharacterFilter {
	// MARK: - Properties
	/// The age to filter by.
	public var age: Int?

	/// The astrological sign identifier to filter by.
	public var astrologicalSign: Int?

	/// The day of birth to filter by.
	public var birthDay: Int?

	/// The month of birth to filter by.
	public var birthMonth: Int?

	/// The bust measurement to filter by.
	public var bust: String?

	/// The height measurement to filter by.
	public var height: String?

	/// The hip measurement to filter by.
	public var hip: String?

	/// The character status identifier to filter by.
	public var status: Int?

	/// The waist measurement to filter by.
	public var waist: String?

	/// The weight measurement to filter by.
	public var weight: String?

	// MARK: - Initializers
	public init(age: Int? = nil, astrologicalSign: Int? = nil, birthDay: Int? = nil, birthMonth: Int? = nil, bust: String? = nil, height: String? = nil, hip: String? = nil, status: Int? = nil, waist: String? = nil, weight: String? = nil) {
		self.age = age
		self.astrologicalSign = astrologicalSign
		self.birthDay = birthDay
		self.birthMonth = birthMonth
		self.bust = bust
		self.height = height
		self.hip = hip
		self.status = status
		self.waist = waist
		self.weight = weight
	}
}

// MARK: - Filterable
extension CharacterFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		return [
			"age": self.age,
			"astrological_sign": self.astrologicalSign,
			"birth_day": self.birthDay,
			"birth_month": self.birthMonth,
			"bust": self.bust,
			"height": self.height,
			"hip": self.hip,
			"status": self.status,
			"waist": self.waist,
			"weight": self.weight
		].filter { $0.value != nil }
	}
}
