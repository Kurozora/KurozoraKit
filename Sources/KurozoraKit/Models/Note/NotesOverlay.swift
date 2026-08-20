//
//  NotesOverlay.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response to a notes overlay batch request.
public struct NotesOverlayResponse: Codable, Sendable {
	// MARK: - Properties
	/// The note resources returned by the server.
	public let data: [NotesOverlayEntry]
}

/// A single note resource for one annotated model.
public struct NotesOverlayEntry: Codable, Sendable {
	// MARK: - Properties
	/// The note's attributes.
	public let attributes: NotesOverlayAttributes

	/// The relationship envelope identifying the annotated item. Exactly one of the
	/// inner keys is populated, matching the kind the request was issued for.
	public let relationships: NotesOverlayRelationships
}

/// The attributes of a note resource.
public struct NotesOverlayAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The note the user wrote.
	public let body: String

	/// The timestamp at which the note was written, in seconds since the Unix epoch.
	public let createdAt: Int?

	/// The timestamp at which the note was last edited, in seconds since the Unix epoch.
	public let updatedAt: Int?
}

/// The polymorphic relationship envelope of a note resource. Exactly
/// one of the per-type keys is populated, matching the kind of the request.
public struct NotesOverlayRelationships: Codable, Sendable {
	// MARK: - Properties
	public let shows: OverlayIdentityList<ShowIdentity>?
	public let literatures: OverlayIdentityList<LiteratureIdentity>?
	public let games: OverlayIdentityList<GameIdentity>?
	public let characters: OverlayIdentityList<CharacterIdentity>?
	public let people: OverlayIdentityList<PersonIdentity>?
	public let studios: OverlayIdentityList<StudioIdentity>?
	public let songs: OverlayIdentityList<SongIdentity>?
	public let episodes: OverlayIdentityList<EpisodeIdentity>?

	/// The identifier of the annotated item, sourced from whichever per-type key the
	/// server populated.
	public var annotatedID: KurozoraItemID? {
		let candidates: [KurozoraItemID?] = [
			self.shows?.data.first?.id,
			self.literatures?.data.first?.id,
			self.games?.data.first?.id,
			self.characters?.data.first?.id,
			self.people?.data.first?.id,
			self.studios?.data.first?.id,
			self.songs?.data.first?.id,
			self.episodes?.data.first?.id
		]

		return candidates.compactMap { $0 }.first
	}
}
