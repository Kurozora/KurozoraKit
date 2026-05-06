//
//  ParentalGuideVoteUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 08/05/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a parental guide vote update response.
public struct ParentalGuideVoteUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a parental guide vote request.
	public let data: ParentalGuideVoteUpdate
}
