//
//  ReviewsOverlay.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response to a reviews overlay batch request.
public struct ReviewsOverlayResponse: Codable, Sendable {
	// MARK: - Properties
	/// The review-state resources returned by the server.
	public let data: [ReviewsOverlayEntry]
}

/// A single review-state resource for one reviewed model.
public struct ReviewsOverlayEntry: Codable, Sendable {
	// MARK: - Properties
	/// The review-state attributes.
	public let attributes: ReviewsOverlayAttributes

	/// The relationship envelope identifying the reviewed item. Exactly one of
	/// the inner keys is populated, matching the kind the request was issued for.
	public let relationships: ReviewsOverlayRelationships
}

/// The attributes of a review-state resource.
public struct ReviewsOverlayAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The score the user assigned, between 0.0 and 5.0.
	public let score: Double

	/// The free-form description the user wrote, or `nil` if they rated without a write-up.
	public let description: String?

	/// The timestamp at which the row was first created, in seconds since the Unix epoch.
	public let createdAt: Int?

	/// The timestamp at which the row was last touched, in seconds since the Unix epoch.
	public let updatedAt: Int?
}

/// The polymorphic relationship envelope of a review-state resource. Exactly one
/// of the per-type keys is populated, matching the kind of the request.
public struct ReviewsOverlayRelationships: Codable, Sendable {
	// MARK: - Properties
	public let shows: OverlayIdentityList<ShowIdentity>?
	public let literatures: OverlayIdentityList<LiteratureIdentity>?
	public let games: OverlayIdentityList<GameIdentity>?
	public let characters: OverlayIdentityList<CharacterIdentity>?
	public let people: OverlayIdentityList<PersonIdentity>?
	public let studios: OverlayIdentityList<StudioIdentity>?
	public let songs: OverlayIdentityList<SongIdentity>?
	public let episodes: OverlayIdentityList<EpisodeIdentity>?

	/// The identifier of the reviewed item, sourced from whichever per-type key
	/// the server populated.
	public var reviewedID: KurozoraItemID? {
		if let id = shows?.data.first?.id { return id }
		if let id = literatures?.data.first?.id { return id }
		if let id = games?.data.first?.id { return id }
		if let id = characters?.data.first?.id { return id }
		if let id = people?.data.first?.id { return id }
		if let id = studios?.data.first?.id { return id }
		if let id = songs?.data.first?.id { return id }
		if let id = episodes?.data.first?.id { return id }
		return nil
	}
}
