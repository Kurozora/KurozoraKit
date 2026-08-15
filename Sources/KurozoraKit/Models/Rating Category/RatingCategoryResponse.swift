//
//  RatingCategoryResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a rating category collection response.
public struct RatingCategoryResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a rating category request.
	public let data: [RatingCategory]
}
