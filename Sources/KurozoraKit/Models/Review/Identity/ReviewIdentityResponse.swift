//
//  ReviewIdentityResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/03/2024.
//  MIT License
//

import Foundation

/// A root object that stores information about a collection of review identities.
public struct ReviewIdentityResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a review identity object request.
	public let data: [ReviewIdentity]

	/// The relative URL to the next page in the paginated response.
	public let next: String?
}
