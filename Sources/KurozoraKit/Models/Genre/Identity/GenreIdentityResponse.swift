//
//  GenreIdentityResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 25/02/2022.
//  MIT License
//

import Foundation

/// A root object that stores information about a collection of genre identities.
public struct GenreIdentityResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a genre identity object request.
	public let data: [GenreIdentity]

	/// The relative URL to the next page in the paginated response.
	public let next: String?
}
