//
//  ParentalGuideResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores the aggregate stats and entries for a media's parental guide.
public struct ParentalGuideResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a parental guide request.
	public let data: ParentalGuideResponseData
}

/// A root object that pairs the aggregate stats with the user-submitted entries.
public struct ParentalGuideResponseData: Codable, Sendable {
	// MARK: - Properties
	/// The aggregate per-category stats.
	public let stats: ParentalGuideStats

	/// The user-submitted entries.
	public let entries: [ParentalGuideEntry]
}
