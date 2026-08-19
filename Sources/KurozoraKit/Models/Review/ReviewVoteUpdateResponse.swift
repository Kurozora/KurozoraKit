//
//  ReviewVoteUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a review vote update response.
public struct ReviewVoteUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a review vote request.
	public let data: ReviewVoteUpdate
}
