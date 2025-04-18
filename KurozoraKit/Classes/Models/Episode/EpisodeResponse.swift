//
//  EpisodeResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 11/10/2018.
//

/// A root object that stores information about a collection of episodes.
public struct EpisodeResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for an episode object request.
	public let data: [Episode]

	/// The relative URL to the next page in the paginated response.
	public let next: String?
}
