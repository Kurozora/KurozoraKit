//
//  ParentalGuideEntryResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a parental guide entry collection response.
public struct ParentalGuideEntryResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a parental guide entry request.
	public let data: [ParentalGuideEntry]
}
