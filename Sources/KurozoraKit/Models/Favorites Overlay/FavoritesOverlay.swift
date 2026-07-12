//
//  FavoritesOverlay.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response to a favorites overlay batch request.
public struct FavoritesOverlayResponse: Codable, Sendable {
	// MARK: - Properties
	/// The favorite-state resources returned by the server.
	public let data: [FavoritesOverlayEntry]
}

/// A single favorite-state resource for one favorable model.
public struct FavoritesOverlayEntry: Codable, Sendable {
	// MARK: - Properties
	/// The favorite-state attributes.
	public let attributes: FavoritesOverlayAttributes

	/// The relationship envelope identifying the favored item. Exactly one of the
	/// inner keys is populated, matching the kind the request was issued for.
	public let relationships: FavoritesOverlayRelationships
}

/// The attributes of a favorite-state resource.
public struct FavoritesOverlayAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The timestamp at which the row was first created, in seconds since the Unix epoch.
	public let createdAt: Int?

	/// The timestamp at which the row was last touched, in seconds since the Unix epoch.
	public let updatedAt: Int?
}

/// The polymorphic relationship envelope of a favorite-state resource. Exactly
/// one of the per-type keys is populated, matching the kind of the request.
public struct FavoritesOverlayRelationships: Codable, Sendable {
	// MARK: - Properties
	public let shows: OverlayIdentityList<ShowIdentity>?
	public let literatures: OverlayIdentityList<LiteratureIdentity>?
	public let games: OverlayIdentityList<GameIdentity>?
	public let characters: OverlayIdentityList<CharacterIdentity>?
	public let people: OverlayIdentityList<PersonIdentity>?
	public let studios: OverlayIdentityList<StudioIdentity>?
	public let songs: OverlayIdentityList<SongIdentity>?

	/// The identifier of the favored item, sourced from whichever per-type key the
	/// server populated.
	public var favoredID: KurozoraItemID? {
		shows?.data.first?.id
			?? literatures?.data.first?.id
			?? games?.data.first?.id
			?? characters?.data.first?.id
			?? people?.data.first?.id
			?? studios?.data.first?.id
			?? songs?.data.first?.id
	}
}
