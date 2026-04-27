//
//  Search.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/05/2022.
//  MIT License
//

import Foundation

/// A root object that stores information about a search resource.
public struct Search: Codable, Sendable {
	// MARK: - Properties
	/// A collection of characters.
	public let characters: ResourceCollection<CharacterIdentity>?

	/// A collection of episodes.
	public let episodes: ResourceCollection<EpisodeIdentity>?

	/// A collection of games.
	public let games: ResourceCollection<GameIdentity>?

	/// A collection of literatures.
	public let literatures: ResourceCollection<LiteratureIdentity>?

	/// A collection of people.
	public let people: ResourceCollection<PersonIdentity>?

	/// A collection of seasons.
	public let seasons: ResourceCollection<SeasonIdentity>?

	/// A collection of shows.
	public let shows: ResourceCollection<ShowIdentity>?

	/// A collection of songs.
	public let songs: ResourceCollection<SongIdentity>?

	/// A collection of studios.
	public let studios: ResourceCollection<StudioIdentity>?

	/// A collection of users.
	public let users: ResourceCollection<UserIdentity>?
}
