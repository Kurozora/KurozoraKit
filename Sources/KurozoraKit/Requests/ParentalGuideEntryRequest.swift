//
//  ParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

/// A root object that stores information about a parental guide entry submission.
public struct ParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	/// The category of the entry.
	public let category: ParentalGuideCategory

	/// The severity rating of the entry.
	public let rating: ParentalGuideRating

	/// The frequency of the content described in the entry.
	public let frequency: ParentalGuideFrequency?

	/// The depiction of the content described in the entry.
	public let depiction: ParentalGuideDepiction?

	/// The user-provided reason describing the content.
	public let reason: String?

	/// Whether the entry's reason contains spoiler material.
	public let isSpoiler: Bool

	// MARK: - Initializers
	/// Initialize a new instance of `ParentalGuideEntryRequest`.
	///
	/// - Parameters:
	///    - category: The category of the entry.
	///    - rating: The severity rating of the entry.
	///    - frequency: The frequency of the content described in the entry.
	///    - depiction: The depiction of the content described in the entry.
	///    - reason: The user-provided reason describing the content.
	///    - isSpoiler: Whether the entry's reason contains spoiler material.
	public init(category: ParentalGuideCategory, rating: ParentalGuideRating, frequency: ParentalGuideFrequency?, depiction: ParentalGuideDepiction?, reason: String?, isSpoiler: Bool) {
		self.category = category
		self.rating = rating
		self.frequency = frequency
		self.depiction = depiction
		self.reason = reason
		self.isSpoiler = isSpoiler
	}
}
