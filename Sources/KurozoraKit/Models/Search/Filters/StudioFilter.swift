//
//  StudioFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying studios.
public struct StudioFilter {
	// MARK: - Properties
	/// The studio type identifier to filter by.
	public let type: Int?

	/// The TV rating identifier to filter by.
	public let tvRating: Int?

	/// The studio address string to filter by.
	public let address: String?

	/// The founding date to filter by, expressed as a time interval since the reference date.
	public let foundedAt: TimeInterval?

	/// The defunct date to filter by, expressed as a time interval since the reference date.
	public let defunctAt: TimeInterval?

	/// Whether to filter by NSFW studios.
	public let isNSFW: Bool?

	// MARK: - Initializers
	public init(
		type: Int? = nil,
		tvRating: Int? = nil,
		address: String? = nil,
		foundedAt: TimeInterval? = nil,
		defunctAt: TimeInterval? = nil,
		isNSFW: Bool? = nil
	) {
		self.type = type
		self.tvRating = tvRating
		self.address = address
		self.foundedAt = foundedAt
		self.defunctAt = defunctAt
		self.isNSFW = isNSFW
	}
}

// MARK: - Filterable
extension StudioFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [
			"type": self.type,
			"tv_rating_id": self.tvRating,
			"address": self.address,
			"founded_at": self.foundedAt,
			"defunct_at": self.defunctAt,
			"is_nsfw": self.isNSFW
		]
	}
}
