//
//  KurozoraKit+Requests.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

// MARK: - Detail & Batch Detail
extension KurozoraKit {
	/// Returns a request that fetches the details of a single fetchable resource.
	///
	/// - Parameter identity: The identity of the resource to fetch.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail<T: Fetchable>(_ identity: T) -> DetailRequest<T> {
		DetailRequest(context: RequestContext(from: self), identity: identity)
	}

	/// Returns a request that fetches the details of multiple fetchable resources.
	///
	/// - Parameter identities: The identities of the resources to fetch.
	///
	/// - Returns: A configured ``BatchDetailRequest`` ready to be executed.
	public func details<T: Fetchable>(_ identities: [T]) -> BatchDetailRequest<T> {
		BatchDetailRequest(context: RequestContext(from: self), identities: identities)
	}

	// MARK: Typed-Relationship Overloads
	/// Returns a request that fetches the details of a show, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the show to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: ShowIdentity, including relationships: [Show.Relationship] = []) -> DetailRequest<ShowIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a game, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the game to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: GameIdentity, including relationships: [Game.Relationship] = []) -> DetailRequest<GameIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a literature, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the literature to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: LiteratureIdentity, including relationships: [Literature.Relationship] = []) -> DetailRequest<LiteratureIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a character, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the character to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: CharacterIdentity, including relationships: [Character.Relationship] = []) -> DetailRequest<CharacterIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a person, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the person to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: PersonIdentity, including relationships: [Person.Relationship] = []) -> DetailRequest<PersonIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of an episode, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the episode to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: EpisodeIdentity, including relationships: [Episode.Relationship] = []) -> DetailRequest<EpisodeIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a studio, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the studio to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: StudioIdentity, including relationships: [Studio.Relationship] = []) -> DetailRequest<StudioIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Returns a request that fetches the details of a song, optionally
	/// including a set of related resources.
	///
	/// - Parameters:
	///   - identity: The identity of the song to fetch.
	///   - relationships: The relationships to include with the response.
	///
	/// - Returns: A configured ``DetailRequest`` ready to be executed.
	public func detail(_ identity: SongIdentity, including relationships: [Song.Relationship] = []) -> DetailRequest<SongIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}
}

// MARK: - List
extension KurozoraKit {
	/// Returns a paginated request that fetches the index of shows.
	public func shows() -> ListRequest<ShowIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of games.
	public func games() -> ListRequest<GameIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of literatures.
	public func literatures() -> ListRequest<LiteratureIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of characters.
	public func characters() -> ListRequest<CharacterIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of people.
	public func people() -> ListRequest<PersonIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of songs.
	public func songs() -> ListRequest<SongIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of studios.
	public func studios() -> ListRequest<StudioIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of genres.
	public func genres() -> ListRequest<GenreIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Genres.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of themes.
	public func themes() -> ListRequest<ThemeIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Themes.index.endpointValue)
	}

	/// Returns a paginated request that fetches the index of upcoming shows.
	public func upcomingShows() -> ListRequest<ShowIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.upcoming.endpointValue)
	}

	/// Returns a paginated request that fetches the index of upcoming games.
	public func upcomingGames() -> ListRequest<GameIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.upcoming.endpointValue)
	}

	/// Returns a paginated request that fetches the index of upcoming literatures.
	public func upcomingLiteratures() -> ListRequest<LiteratureIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.upcoming.endpointValue)
	}
}

// MARK: - Relationships (Shows)
extension KurozoraKit {
	/// Returns a request that fetches the cast of the specified show.
	///
	/// - Parameter show: The identity of the show whose cast to fetch.
	///
	/// - Returns: A configured relationship request.
	public func cast(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.cast(show).endpointValue)
	}

	/// Returns a request that fetches the characters of the specified show.
	///
	/// - Parameter show: The identity of the show whose characters to fetch.
	///
	/// - Returns: A configured relationship request.
	public func characters(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.characters(show).endpointValue)
	}

	/// Returns a request that fetches the people of the specified show.
	///
	/// - Parameter show: The identity of the show whose people to fetch.
	///
	/// - Returns: A configured relationship request.
	public func people(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.people(show).endpointValue)
	}

	/// Returns a request that fetches the seasons of the specified show.
	///
	/// - Parameter show: The identity of the show whose seasons to fetch.
	///
	/// - Returns: A configured relationship request.
	public func seasons(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<SeasonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.seasons(show).endpointValue)
	}

	/// Returns a request that fetches the songs of the specified show.
	///
	/// - Parameter show: The identity of the show whose songs to fetch.
	///
	/// - Returns: A configured relationship request.
	public func songs(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<ShowSong>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.songs(show).endpointValue)
	}

	/// Returns a request that fetches the studios of the specified show.
	///
	/// - Parameter show: The identity of the show whose studios to fetch.
	///
	/// - Returns: A configured relationship request.
	public func studios(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.studios(show).endpointValue)
	}

	/// Returns a request that fetches the shows related to the specified show.
	///
	/// - Parameter show: The identity of the show whose related shows to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedShows(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedShows(show).endpointValue)
	}

	/// Returns a request that fetches the literatures related to the specified show.
	///
	/// - Parameter show: The identity of the show whose related literatures to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedLiteratures(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedLiteratures(show).endpointValue)
	}

	/// Returns a request that fetches the games related to the specified show.
	///
	/// - Parameter show: The identity of the show whose related games to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedGames(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedGames(show).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified show.
	///
	/// - Parameter show: The identity of the show whose reviews to fetch.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.reviews(show).endpointValue)
	}

	/// Returns a request that fetches more shows from the same studio as the specified show.
	///
	/// - Parameter show: The identity of the show whose studio to use as the source.
	///
	/// - Returns: A configured relationship request.
	public func moreByStudio(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.moreByStudio(show).endpointValue)
	}
}

// MARK: - Relationships (Games)
extension KurozoraKit {
	/// Returns a request that fetches the cast of the specified game.
	///
	/// - Parameter game: The identity of the game whose cast to fetch.
	///
	/// - Returns: A configured relationship request.
	public func cast(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.cast(game).endpointValue)
	}

	/// Returns a request that fetches the characters of the specified game.
	///
	/// - Parameter game: The identity of the game whose characters to fetch.
	///
	/// - Returns: A configured relationship request.
	public func characters(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.characters(game).endpointValue)
	}

	/// Returns a request that fetches the people of the specified game.
	///
	/// - Parameter game: The identity of the game whose people to fetch.
	///
	/// - Returns: A configured relationship request.
	public func people(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.people(game).endpointValue)
	}

	/// Returns a request that fetches the studios of the specified game.
	///
	/// - Parameter game: The identity of the game whose studios to fetch.
	///
	/// - Returns: A configured relationship request.
	public func studios(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.studios(game).endpointValue)
	}

	/// Returns a request that fetches the shows related to the specified game.
	///
	/// - Parameter game: The identity of the game whose related shows to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedShows(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedShows(game).endpointValue)
	}

	/// Returns a request that fetches the literatures related to the specified game.
	///
	/// - Parameter game: The identity of the game whose related literatures to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedLiteratures(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedLiteratures(game).endpointValue)
	}

	/// Returns a request that fetches the games related to the specified game.
	///
	/// - Parameter game: The identity of the game whose related games to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedGames(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedGames(game).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified game.
	///
	/// - Parameter game: The identity of the game whose reviews to fetch.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.reviews(game).endpointValue)
	}

	/// Returns a request that fetches more games from the same studio as the specified game.
	///
	/// - Parameter game: The identity of the game whose studio to use as the source.
	///
	/// - Returns: A configured relationship request.
	public func moreByStudio(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.moreByStudio(game).endpointValue)
	}
}

// MARK: - Relationships (Literatures)
extension KurozoraKit {
	/// Returns a request that fetches the cast of the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose cast to fetch.
	///
	/// - Returns: A configured relationship request.
	public func cast(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.cast(literature).endpointValue)
	}

	/// Returns a request that fetches the characters of the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose characters to fetch.
	///
	/// - Returns: A configured relationship request.
	public func characters(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.characters(literature).endpointValue)
	}

	/// Returns a request that fetches the people of the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose people to fetch.
	///
	/// - Returns: A configured relationship request.
	public func people(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.people(literature).endpointValue)
	}

	/// Returns a request that fetches the studios of the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose studios to fetch.
	///
	/// - Returns: A configured relationship request.
	public func studios(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.studios(literature).endpointValue)
	}

	/// Returns a request that fetches the shows related to the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose related shows to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedShows(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedShows(literature).endpointValue)
	}

	/// Returns a request that fetches the literatures related to the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose related literatures to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedLiteratures(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedLiteratures(literature).endpointValue)
	}

	/// Returns a request that fetches the games related to the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose related games to fetch.
	///
	/// - Returns: A configured relationship request.
	public func relatedGames(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedGames(literature).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose reviews to fetch.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.reviews(literature).endpointValue)
	}

	/// Returns a request that fetches more literatures from the same studio
	/// as the specified literature.
	///
	/// - Parameter literature: The identity of the literature whose studio to use as the source.
	///
	/// - Returns: A configured relationship request.
	public func moreByStudio(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.moreByStudio(literature).endpointValue)
	}
}

// MARK: - Relationships (Characters, People, Studios, Songs, Episodes)
extension KurozoraKit {
	/// Returns a request that fetches the people associated with the specified character.
	///
	/// - Parameter character: The identity of the character.
	///
	/// - Returns: A configured relationship request.
	public func people(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.people(character).endpointValue)
	}

	/// Returns a request that fetches the shows associated with the specified character.
	///
	/// - Parameter character: The identity of the character.
	///
	/// - Returns: A configured relationship request.
	public func shows(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.shows(character).endpointValue)
	}

	/// Returns a request that fetches the games associated with the specified character.
	///
	/// - Parameter character: The identity of the character.
	///
	/// - Returns: A configured relationship request.
	public func games(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.games(character).endpointValue)
	}

	/// Returns a request that fetches the literatures associated with the specified character.
	///
	/// - Parameter character: The identity of the character.
	///
	/// - Returns: A configured relationship request.
	public func literatures(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.literatures(character).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified character.
	///
	/// - Parameter character: The identity of the character.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.reviews(character).endpointValue)
	}

	/// Returns a request that fetches the characters associated with the specified person.
	///
	/// - Parameter person: The identity of the person.
	///
	/// - Returns: A configured relationship request.
	public func characters(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.characters(person).endpointValue)
	}

	/// Returns a request that fetches the shows associated with the specified person.
	///
	/// - Parameter person: The identity of the person.
	///
	/// - Returns: A configured relationship request.
	public func shows(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.shows(person).endpointValue)
	}

	/// Returns a request that fetches the games associated with the specified person.
	///
	/// - Parameter person: The identity of the person.
	///
	/// - Returns: A configured relationship request.
	public func games(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.games(person).endpointValue)
	}

	/// Returns a request that fetches the literatures associated with the specified person.
	///
	/// - Parameter person: The identity of the person.
	///
	/// - Returns: A configured relationship request.
	public func literatures(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.literatures(person).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified person.
	///
	/// - Parameter person: The identity of the person.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.reviews(person).endpointValue)
	}

	/// Returns a request that fetches the shows associated with the specified studio.
	///
	/// - Parameter studio: The identity of the studio.
	///
	/// - Returns: A configured relationship request.
	public func shows(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.shows(studio).endpointValue)
	}

	/// Returns a request that fetches the games associated with the specified studio.
	///
	/// - Parameter studio: The identity of the studio.
	///
	/// - Returns: A configured relationship request.
	public func games(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.games(studio).endpointValue)
	}

	/// Returns a request that fetches the literatures associated with the specified studio.
	///
	/// - Parameter studio: The identity of the studio.
	///
	/// - Returns: A configured relationship request.
	public func literatures(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.literatures(studio).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified studio.
	///
	/// - Parameter studio: The identity of the studio.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.reviews(studio).endpointValue)
	}

	/// Returns a request that fetches the shows associated with the specified song.
	///
	/// - Parameter song: The identity of the song.
	///
	/// - Returns: A configured relationship request.
	public func shows(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.shows(song).endpointValue)
	}

	/// Returns a request that fetches the games associated with the specified song.
	///
	/// - Parameter song: The identity of the song.
	///
	/// - Returns: A configured relationship request.
	public func games(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.games(song).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified song.
	///
	/// - Parameter song: The identity of the song.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.reviews(song).endpointValue)
	}

	/// Returns a request that fetches the reviews of the specified episode.
	///
	/// - Parameter episode: The identity of the episode.
	///
	/// - Returns: A configured relationship request.
	public func reviews(for episode: EpisodeIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.reviews(episode).endpointValue)
	}

	/// Returns a request that fetches suggestions for the specified episode.
	///
	/// - Parameter episode: The identity of the episode.
	///
	/// - Returns: A configured relationship request.
	public func suggestions(for episode: EpisodeIdentity) -> RelationshipRequest<ResourceCollection<EpisodeIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.suggestions(episode).endpointValue)
	}
}

// MARK: - Search
extension KurozoraKit {
	/// Returns a request that performs a search.
	///
	/// - Parameters:
	///   - scope: The scope to search within.
	///   - types: The resource types to include in the search.
	///   - query: The text to search for.
	///
	/// - Returns: A configured ``SearchRequest`` ready to be executed.
	public func search(_ scope: SearchScope, types: [SearchType], query: String) -> SearchRequest {
		SearchRequest(context: RequestContext(from: self), scope: scope, types: types, query: query)
	}
}

// MARK: - Library
extension KurozoraKit {
	/// Returns a request that fetches the authenticated user's library
	/// filtered by kind and status.
	///
	/// - Parameters:
	///   - kind: The kind of library to fetch.
	///   - status: The status to filter on.
	///
	/// - Returns: A configured ``LibraryRequest`` ready to be executed.
	public func library(_ kind: LibraryKind, status: LibraryStatus) -> LibraryRequest {
		LibraryRequest(context: RequestContext(from: self), kind: kind, status: status)
	}

	/// Returns a request that adds one or more items to the authenticated
	/// user's library.
	///
	/// - Parameters:
	///   - kind: The kind of library to modify.
	///   - status: The status to assign to the items.
	///   - itemIDs: The identifiers of the items to add.
	///
	/// - Returns: A configured ``LibraryAddRequest`` ready to be executed.
	public func addToLibrary(_ kind: LibraryKind, status: LibraryStatus, itemIDs: [KurozoraItemID]) -> LibraryAddRequest {
		LibraryAddRequest(context: RequestContext(from: self), kind: kind, status: status, itemIDs: itemIDs)
	}

	/// Returns a request that updates one or more entries in the authenticated
	/// user's library.
	///
	/// - Parameters:
	///   - kind: The kind of library to modify.
	///   - itemIDs: The identifiers of the items to update.
	///
	/// - Returns: A configured ``LibraryUpdateRequest`` ready to be executed.
	public func updateInLibrary(_ kind: LibraryKind, itemIDs: [KurozoraItemID]) -> LibraryUpdateRequest {
		LibraryUpdateRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}

	/// Returns a request that removes one or more items from the authenticated
	/// user's library.
	///
	/// - Parameters:
	///   - kind: The kind of library to modify.
	///   - itemIDs: The identifiers of the items to remove.
	///
	/// - Returns: A configured ``LibraryRemoveRequest`` ready to be executed.
	public func removeFromLibrary(_ kind: LibraryKind, itemIDs: [KurozoraItemID]) -> LibraryRemoveRequest {
		LibraryRemoveRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}
}

// MARK: - Rate
extension KurozoraKit {
	/// Returns a request that submits a rating for the specified show.
	///
	/// - Parameters:
	///   - identity: The identity of the show to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: ShowIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified game.
	///
	/// - Parameters:
	///   - identity: The identity of the game to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: GameIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified literature.
	///
	/// - Parameters:
	///   - identity: The identity of the literature to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: LiteratureIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified character.
	///
	/// - Parameters:
	///   - identity: The identity of the character to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: CharacterIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified person.
	///
	/// - Parameters:
	///   - identity: The identity of the person to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: PersonIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified song.
	///
	/// - Parameters:
	///   - identity: The identity of the song to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: SongIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified episode.
	///
	/// - Parameters:
	///   - identity: The identity of the episode to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: EpisodeIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.rate(identity).endpointValue, score: score)
	}

	/// Returns a request that submits a rating for the specified studio.
	///
	/// - Parameters:
	///   - identity: The identity of the studio to rate.
	///   - score: The rating to submit.
	///
	/// - Returns: A configured ``RateRequest`` ready to be executed.
	public func rate(_ identity: StudioIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.rate(identity).endpointValue, score: score)
	}
}

// MARK: - Favorite & Reminder
extension KurozoraKit {
	/// The reminder subscription URL for the authenticated user.
	public var reminderSubscriptionURL: URL {
		let path = KKEndpoint.Me.Reminders.download.endpointValue
		let base = self.apiEndpoint.baseURL
		return URL(string: path, relativeTo: URL(string: base))?.absoluteURL
			?? URL(string: base + path)
			?? URL(fileURLWithPath: "")
	}

	/// Returns a request that toggles the favorite status of one or more
	/// library items.
	///
	/// - Parameters:
	///   - kind: The kind of library that contains the items.
	///   - itemIDs: The identifiers of the items to toggle.
	///
	/// - Returns: A configured ``FavoriteRequest`` ready to be executed.
	public func toggleFavorite(inLibrary kind: LibraryKind, itemIDs: [KurozoraItemID]) -> FavoriteRequest {
		FavoriteRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}

	/// Returns a request that toggles the reminder status of one or more
	/// library items.
	///
	/// - Parameters:
	///   - kind: The kind of library that contains the items.
	///   - itemIDs: The identifiers of the items to toggle.
	///
	/// - Returns: A configured ``ReminderRequest`` ready to be executed.
	public func toggleReminder(inLibrary kind: LibraryKind, itemIDs: [KurozoraItemID]) -> ReminderRequest {
		ReminderRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}
}

// MARK: - Authentication
extension KurozoraKit {
	/// Returns a request that signs a user in with an email address and password.
	///
	/// - Parameters:
	///   - email: The user's email address.
	///   - password: The user's password.
	///
	/// - Returns: A configured ``SignInRequest`` ready to be executed.
	public func signIn(email: String, password: String) -> SignInRequest {
		SignInRequest(context: RequestContext(from: self), email: email, password: password)
	}

	/// Returns a request that signs a user in or registers a new account
	/// using Sign in with Apple.
	///
	/// - Parameter token: The identity token returned by Sign in with Apple.
	///
	/// - Returns: A configured ``SignInWithAppleRequest`` ready to be executed.
	public func signIn(withAppleIDToken token: String) -> SignInWithAppleRequest {
		SignInWithAppleRequest(context: RequestContext(from: self), token: token)
	}

	/// Returns a request that resolves a two-factor authentication challenge.
	///
	/// - Parameter token: The challenge token issued by ``SignInRequest``.
	///
	/// - Returns: A configured ``TwoFactorChallengeRequest`` ready to be executed.
	public func submitTwoFactorChallenge(token: String) -> TwoFactorChallengeRequest {
		TwoFactorChallengeRequest(context: RequestContext(from: self), challengeToken: token)
	}

	#if !os(watchOS)
	/// Returns a request that registers a new user account.
	///
	/// - Parameters:
	///   - username: The username for the new account.
	///   - emailAddress: The email address for the new account.
	///   - password: The password for the new account.
	///   - profileImage: An optional profile image for the new account.
	///
	/// - Returns: A configured ``SignUpRequest`` ready to be executed.
	public func signUp(username: String, emailAddress: String, password: String, profileImage: UIImage? = nil) -> SignUpRequest {
		SignUpRequest(context: RequestContext(from: self), username: username, emailAddress: emailAddress, password: password, profileImage: profileImage)
	}
	#endif

	/// Returns a request that sends a password-reset link to the specified
	/// email address.
	///
	/// - Parameter emailAddress: The email address that should receive the reset link.
	///
	/// - Returns: A configured ``ResetPasswordRequest`` ready to be executed.
	public func resetPassword(emailAddress: String) -> ResetPasswordRequest {
		ResetPasswordRequest(context: RequestContext(from: self), emailAddress: emailAddress)
	}

	/// Returns a request that deletes the authenticated user's account.
	///
	/// - Parameter password: The user's password, used to confirm the deletion.
	///
	/// - Returns: A configured ``DeleteAccountRequest`` ready to be executed.
	public func deleteAccount(password: String) -> DeleteAccountRequest {
		DeleteAccountRequest(context: RequestContext(from: self), password: password)
	}

	/// Returns a request that signs the authenticated user out by invalidating
	/// the current access token.
	///
	/// - Returns: A configured ``SignOutRequest`` ready to be executed.
	public func signOut() -> SignOutRequest {
		let tokenIdentifier = self.authenticationKey.components(separatedBy: "|")[0]
		return SignOutRequest(context: RequestContext(from: self), accessTokenIdentifier: tokenIdentifier)
	}
}

// MARK: - Profile (Me)
extension KurozoraKit {
	/// Returns a request that fetches the authenticated user's profile details.
	public func profileDetails() -> ProfileDetailsRequest {
		ProfileDetailsRequest(context: RequestContext(from: self))
	}

	#if !os(watchOS)
	/// Returns a request that updates the authenticated user's profile information.
	///
	/// - Parameter update: The profile fields to update.
	///
	/// - Returns: A configured ``UpdateProfileRequest`` ready to be executed.
	public func updateProfile(_ update: ProfileUpdateRequest) -> UpdateProfileRequest {
		UpdateProfileRequest(context: RequestContext(from: self), update: update)
	}
	#endif

	/// Returns a request that fetches the authenticated user's followers or
	/// following list.
	///
	/// - Parameter listType: The follow list to fetch.
	///
	/// - Returns: A configured ``MyFollowListRequest`` ready to be executed.
	public func myFollowList(_ listType: UsersListType) -> MyFollowListRequest {
		MyFollowListRequest(context: RequestContext(from: self), listType: listType)
	}

	/// Returns a request that fetches the authenticated user's blocked users list.
	///
	/// - Returns: A configured ``MyBlockListRequest`` ready to be executed.
	public func myBlockList() -> MyBlockListRequest {
		MyBlockListRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the authenticated user's up-next episodes.
	///
	/// - Parameter showIdentity: An optional show to scope the up-next list to.
	///
	/// - Returns: A configured ``UpNextEpisodesRequest`` ready to be executed.
	public func upNextEpisodes(for showIdentity: ShowIdentity? = nil) -> UpNextEpisodesRequest {
		UpNextEpisodesRequest(context: RequestContext(from: self), showIdentity: showIdentity)
	}
}

// MARK: - Sessions & Access Tokens
extension KurozoraKit {
	/// Returns a request that fetches the authenticated user's access tokens.
	public func accessTokens() -> AccessTokensRequest {
		AccessTokensRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the details for the specified access token.
	///
	/// - Parameter accessToken: The access token whose details to fetch.
	///
	/// - Returns: A configured ``AccessTokenDetailRequest`` ready to be executed.
	public func accessTokenDetail(_ accessToken: String) -> AccessTokenDetailRequest {
		AccessTokenDetailRequest(context: RequestContext(from: self), accessToken: accessToken)
	}

	/// Returns a request that registers an APN device token with the current
	/// access token.
	///
	/// - Parameter apnDeviceToken: The APN device token to register.
	///
	/// - Returns: A configured ``UpdateAPNTokenRequest`` ready to be executed.
	public func updateAccessToken(withAPNToken apnDeviceToken: String) -> UpdateAPNTokenRequest {
		let tokenID = self.authenticationKey.components(separatedBy: "|")[0]
		return UpdateAPNTokenRequest(context: RequestContext(from: self), accessTokenID: tokenID, apnDeviceToken: apnDeviceToken)
	}

	/// Returns a request that deletes the specified access token from the
	/// authenticated user's active sessions.
	///
	/// - Parameter accessToken: The access token to delete.
	///
	/// - Returns: A configured ``DeleteAccessTokenRequest`` ready to be executed.
	public func deleteAccessToken(_ accessToken: String) -> DeleteAccessTokenRequest {
		let tokenID = accessToken.components(separatedBy: "|")[0]
		return DeleteAccessTokenRequest(context: RequestContext(from: self), accessTokenID: tokenID)
	}

	/// Returns a request that fetches the authenticated user's sessions.
	public func sessions() -> SessionsRequest {
		SessionsRequest(context: RequestContext(from: self))
	}

	/// Returns a request that deletes the specified session from the
	/// authenticated user's active sessions.
	///
	/// - Parameter sessionIdentity: The identity of the session to delete.
	///
	/// - Returns: A configured ``DeleteSessionRequest`` ready to be executed.
	public func deleteSession(_ sessionIdentity: SessionIdentity) -> DeleteSessionRequest {
		DeleteSessionRequest(context: RequestContext(from: self), sessionIdentity: sessionIdentity)
	}
}

// MARK: - Library Extras
extension KurozoraKit {
	/// Returns a request that clears all items from the authenticated user's
	/// library for the specified kind.
	///
	/// - Parameters:
	///   - kind: The kind of library to clear.
	///   - password: The user's password, used to confirm the clear.
	///
	/// - Returns: A configured ``ClearLibraryRequest`` ready to be executed.
	public func clearLibrary(_ kind: LibraryKind, password: String) -> ClearLibraryRequest {
		ClearLibraryRequest(context: RequestContext(from: self), kind: kind, password: password)
	}

	/// Returns a request that imports a library file into the authenticated
	/// user's library.
	///
	/// - Parameters:
	///   - kind: The kind of library to import into.
	///   - service: The source service that produced the file.
	///   - behavior: The merge behavior to apply during import.
	///   - filePath: The location of the file to import.
	///
	/// - Returns: A configured ``ImportLibraryRequest`` ready to be executed.
	public func importLibrary(_ kind: LibraryKind, service: LibraryImport.Service, behavior: LibraryImport.Behavior, filePath: URL) -> ImportLibraryRequest {
		ImportLibraryRequest(context: RequestContext(from: self), kind: kind, service: service, behavior: behavior, filePath: filePath)
	}

	/// Returns a request that fetches the authenticated user's favorites for
	/// the specified library kind.
	///
	/// - Parameter kind: The kind of library to fetch favorites for.
	///
	/// - Returns: A configured ``MyFavoritesRequest`` ready to be executed.
	public func myFavorites(_ kind: LibraryKind) -> MyFavoritesRequest {
		MyFavoritesRequest(context: RequestContext(from: self), kind: kind)
	}

	/// Returns a request that fetches the authenticated user's reminders for
	/// the specified library kind.
	///
	/// - Parameter kind: The kind of library to fetch reminders for.
	///
	/// - Returns: A configured ``MyRemindersRequest`` ready to be executed.
	public func myReminders(_ kind: LibraryKind) -> MyRemindersRequest {
		MyRemindersRequest(context: RequestContext(from: self), kind: kind)
	}
}

// MARK: - Notifications
extension KurozoraKit {
	/// Returns a request that fetches the authenticated user's notifications.
	public func notifications() -> NotificationsRequest {
		NotificationsRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the details of a notification.
	///
	/// - Parameter identity: The identity of the notification to fetch.
	///
	/// - Returns: A configured ``NotificationDetailRequest`` ready to be executed.
	public func notificationDetail(_ identity: any KurozoraItem) -> NotificationDetailRequest {
		NotificationDetailRequest(context: RequestContext(from: self), identity: identity)
	}

	/// Returns a request that updates the read status of a notification.
	///
	/// - Parameters:
	///   - notificationID: The identifier of the notification to update.
	///   - readStatus: The new read status for the notification.
	///
	/// - Returns: A configured ``UpdateNotificationRequest`` ready to be executed.
	public func updateNotification(_ notificationID: String, readStatus: ReadStatus) -> UpdateNotificationRequest {
		UpdateNotificationRequest(context: RequestContext(from: self), notificationID: notificationID, readStatus: readStatus)
	}

	/// Returns a request that deletes a notification.
	///
	/// - Parameter identity: The identity of the notification to delete.
	///
	/// - Returns: A configured ``DeleteNotificationRequest`` ready to be executed.
	public func deleteNotification(_ identity: any KurozoraItem) -> DeleteNotificationRequest {
		DeleteNotificationRequest(context: RequestContext(from: self), identity: identity)
	}
}

// MARK: - User Relations
extension KurozoraKit {
	/// Returns a request that fetches the global user index.
	///
	/// - Returns: A configured ``UserIndexRequest`` ready to be executed.
	public func userIndex() -> UserIndexRequest {
		UserIndexRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches a user's followers or following list.
	///
	/// - Parameters:
	///   - userIdentity: The identity of the user.
	///   - listType: The follow list to fetch.
	///
	/// - Returns: A configured ``UserFollowListRequest`` ready to be executed.
	public func followList(forUser userIdentity: UserIdentity, _ listType: UsersListType) -> UserFollowListRequest {
		UserFollowListRequest(context: RequestContext(from: self), userIdentity: userIdentity, listType: listType)
	}

	/// Returns a request that fetches a user's block list.
	///
	/// - Parameter userIdentity: The identity of the user.
	///
	/// - Returns: A configured ``UserBlockListRequest`` ready to be executed.
	public func blockList(forUser userIdentity: UserIdentity) -> UserBlockListRequest {
		UserBlockListRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Returns a request that toggles the follow status for the specified user.
	///
	/// - Parameter userIdentity: The identity of the user to follow or unfollow.
	///
	/// - Returns: A configured ``ToggleFollowRequest`` ready to be executed.
	public func toggleFollow(_ userIdentity: UserIdentity) -> ToggleFollowRequest {
		ToggleFollowRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Returns a request that toggles the block status for the specified user.
	///
	/// - Parameter userIdentity: The identity of the user to block or unblock.
	///
	/// - Returns: A configured ``ToggleBlockRequest`` ready to be executed.
	public func toggleBlock(_ userIdentity: UserIdentity) -> ToggleBlockRequest {
		ToggleBlockRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Returns a request that fetches a user's favorites filtered by library kind.
	///
	/// - Parameters:
	///   - userIdentity: The identity of the user.
	///   - kind: The kind of library to fetch favorites for.
	///
	/// - Returns: A configured ``UserFavoritesRequest`` ready to be executed.
	public func favorites(forUser userIdentity: UserIdentity, kind: LibraryKind) -> UserFavoritesRequest {
		UserFavoritesRequest(context: RequestContext(from: self), userIdentity: userIdentity, kind: kind)
	}

	/// Returns a request that fetches a user's library entries with the
	/// specified filters.
	///
	/// - Parameters:
	///   - userIdentity: The identity of the user.
	///   - kind: The kind of library to fetch.
	///   - status: The status to filter on.
	///
	/// - Returns: A configured ``UserLibraryRequest`` ready to be executed.
	public func library(forUser userIdentity: UserIdentity, kind: LibraryKind, status: LibraryStatus) -> UserLibraryRequest {
		UserLibraryRequest(context: RequestContext(from: self), userIdentity: userIdentity, kind: kind, status: status)
	}

	/// Returns a request that fetches the reviews written by the specified user.
	///
	/// - Parameter userIdentity: The identity of the user.
	///
	/// - Returns: A configured ``UserReviewsRequest`` ready to be executed.
	public func reviews(forUser userIdentity: UserIdentity) -> UserReviewsRequest {
		UserReviewsRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Returns a request that searches for users matching the specified username.
	///
	/// - Parameter username: The username to search for.
	///
	/// - Returns: A configured ``SearchUsersRequest`` ready to be executed.
	public func searchUsers(_ username: String) -> SearchUsersRequest {
		SearchUsersRequest(context: RequestContext(from: self), username: username)
	}
}

// MARK: - Feed Messages
extension KurozoraKit {
	/// Returns a request that fetches feed messages for the specified user.
	///
	/// - Parameter userIdentity: The identity of the user.
	///
	/// - Returns: A configured ``UserFeedMessagesRequest`` ready to be executed.
	public func feedMessages(forUser userIdentity: UserIdentity) -> UserFeedMessagesRequest {
		UserFeedMessagesRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Returns a request that fetches the authenticated user's feed messages.
	public func myFeedMessages() -> MyFeedMessagesRequest {
		MyFeedMessagesRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the home feed messages.
	public func feedHome() -> FeedHomeRequest {
		FeedHomeRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the explore feed messages.
	public func feedExplore() -> FeedExploreRequest {
		FeedExploreRequest(context: RequestContext(from: self))
	}

	/// Returns a request that posts a new feed message.
	///
	/// - Parameter message: The message to post.
	///
	/// - Returns: A configured ``PostFeedMessageRequest`` ready to be executed.
	public func postFeedMessage(_ message: FeedMessageRequest) -> PostFeedMessageRequest {
		PostFeedMessageRequest(context: RequestContext(from: self), message: message)
	}

	/// Returns a request that fetches the details of a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``FeedMessageDetailRequest`` ready to be executed.
	public func feedMessageDetail(_ messageIdentity: FeedMessageIdentity) -> FeedMessageDetailRequest {
		FeedMessageDetailRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that fetches the replies of a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``FeedMessageRepliesRequest`` ready to be executed.
	public func replies(forFeedMessage messageIdentity: FeedMessageIdentity) -> FeedMessageRepliesRequest {
		FeedMessageRepliesRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that fetches the quote re-shares of a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``FeedMessageQuotesRequest`` ready to be executed.
	public func quotes(forFeedMessage messageIdentity: FeedMessageIdentity) -> FeedMessageQuotesRequest {
		FeedMessageQuotesRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that fetches the simple re-shares of a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``FeedMessageReSharesRequest`` ready to be executed.
	public func reShares(forFeedMessage messageIdentity: FeedMessageIdentity) -> FeedMessageReSharesRequest {
		FeedMessageReSharesRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that updates a feed message.
	///
	/// - Parameter update: The update to apply to the feed message.
	///
	/// - Returns: A configured ``UpdateFeedMessageRequest`` ready to be executed.
	public func updateFeedMessage(_ update: FeedMessageUpdateRequest) -> UpdateFeedMessageRequest {
		UpdateFeedMessageRequest(context: RequestContext(from: self), update: update)
	}

	/// Returns a request that hearts or un-hearts a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``HeartFeedMessageRequest`` ready to be executed.
	public func heartFeedMessage(_ messageIdentity: FeedMessageIdentity) -> HeartFeedMessageRequest {
		HeartFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that pins or unpins a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message.
	///
	/// - Returns: A configured ``PinFeedMessageRequest`` ready to be executed.
	public func pinFeedMessage(_ messageIdentity: FeedMessageIdentity) -> PinFeedMessageRequest {
		PinFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Returns a request that deletes a feed message.
	///
	/// - Parameter messageIdentity: The identity of the feed message to delete.
	///
	/// - Returns: A configured ``DeleteFeedMessageRequest`` ready to be executed.
	public func deleteFeedMessage(_ messageIdentity: FeedMessageIdentity) -> DeleteFeedMessageRequest {
		DeleteFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}
}

// MARK: - Watch Status & Season Episodes
extension KurozoraKit {
	/// Returns a request that toggles the watch status of an episode.
	///
	/// - Parameter episodeIdentity: The identity of the episode.
	///
	/// - Returns: A configured ``UpdateEpisodeWatchStatusRequest`` ready to be executed.
	public func updateWatchStatus(forEpisode episodeIdentity: EpisodeIdentity) -> UpdateEpisodeWatchStatusRequest {
		UpdateEpisodeWatchStatusRequest(context: RequestContext(from: self), episodeIdentity: episodeIdentity)
	}

	/// Returns a request that toggles the watch status of a season.
	///
	/// - Parameter seasonIdentity: The identity of the season.
	///
	/// - Returns: A configured ``UpdateSeasonWatchStatusRequest`` ready to be executed.
	public func updateWatchStatus(forSeason seasonIdentity: SeasonIdentity) -> UpdateSeasonWatchStatusRequest {
		UpdateSeasonWatchStatusRequest(context: RequestContext(from: self), seasonIdentity: seasonIdentity)
	}

	/// Returns a request that fetches the episodes for a season.
	///
	/// - Parameter seasonIdentity: The identity of the season.
	///
	/// - Returns: A configured ``SeasonEpisodesRequest`` ready to be executed.
	public func episodes(for seasonIdentity: SeasonIdentity) -> SeasonEpisodesRequest {
		SeasonEpisodesRequest(context: RequestContext(from: self), seasonIdentity: seasonIdentity)
	}
}

// MARK: - Browse
extension KurozoraKit {
	/// Returns a request that fetches the explore page content.
	public func explore() -> ExploreRequest {
		ExploreRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the contents of an explore category.
	///
	/// - Parameter categoryIdentity: The identity of the explore category to fetch.
	///
	/// - Returns: A configured ``ExploreCategoryRequest`` ready to be executed.
	public func exploreCategory(_ categoryIdentity: ExploreCategoryIdentity) -> ExploreCategoryRequest {
		ExploreCategoryRequest(context: RequestContext(from: self), categoryIdentity: categoryIdentity)
	}

	/// Returns a request that fetches the schedule for the specified type and date.
	///
	/// - Parameters:
	///   - type: The kind of schedule to fetch.
	///   - date: The date to fetch the schedule for.
	///
	/// - Returns: A configured ``ScheduleRequest`` ready to be executed.
	public func schedule(for type: KKScheduleType, in date: Date) -> ScheduleRequest {
		ScheduleRequest(context: RequestContext(from: self), type: type, date: date)
	}

	/// Returns a request that fetches the list of available recaps.
	public func recaps() -> RecapsRequest {
		RecapsRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the recap for the specified year and month.
	///
	/// - Parameters:
	///   - year: The year of the recap.
	///   - month: The month of the recap.
	///
	/// - Returns: A configured ``RecapDetailRequest`` ready to be executed.
	public func recap(year: String, month: String) -> RecapDetailRequest {
		RecapDetailRequest(context: RequestContext(from: self), year: year, month: month)
	}

	/// Returns a request that fetches search suggestions for the specified query.
	///
	/// - Parameters:
	///   - scope: The scope to search within.
	///   - types: The resource types to include in the suggestions.
	///   - query: The text to suggest results for.
	///
	/// - Returns: A configured ``SearchSuggestionsRequest`` ready to be executed.
	public func searchSuggestions(_ scope: SearchScope, types: [SearchType], query: String) -> SearchSuggestionsRequest {
		SearchSuggestionsRequest(context: RequestContext(from: self), scope: scope, types: types, query: query)
	}
}

// MARK: - Misc
extension KurozoraKit {
	/// Returns a request that fetches service meta information.
	public func info() -> InfoRequest {
		InfoRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the application settings.
	public func settings() -> SettingsRequest {
		SettingsRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches a collection of random images for the
	/// specified kind and collection.
	///
	/// - Parameters:
	///   - kind: The kind of media.
	///   - collection: The collection to draw images from.
	///
	/// - Returns: A configured ``RandomImagesRequest`` ready to be executed.
	public func randomImages(of kind: MediaKind, from collection: MediaCollection) -> RandomImagesRequest {
		RandomImagesRequest(context: RequestContext(from: self), kind: kind, collection: collection)
	}

	/// Returns a request that fetches the latest privacy policy.
	public func privacyPolicy() -> PrivacyPolicyRequest {
		PrivacyPolicyRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the latest terms of use.
	public func termsOfUse() -> TermsOfUseRequest {
		TermsOfUseRequest(context: RequestContext(from: self))
	}

	/// Returns a request that verifies a transaction receipt.
	///
	/// - Parameter receipt: The transaction receipt to verify.
	///
	/// - Returns: A configured ``VerifyReceiptRequest`` ready to be executed.
	public func verifyReceipt(_ receipt: String) -> VerifyReceiptRequest {
		VerifyReceiptRequest(context: RequestContext(from: self), receipt: receipt)
	}

	/// Returns a request that verifies StoreKit 2 signed JWS transactions and syncs the user's entitlements.
	///
	/// - Parameter transactions: The signed JWS strings produced by StoreKit 2 to submit for verification.
	///
	/// - Returns: A configured ``VerifyTransactionsRequest`` ready to be executed.
	public func verifyTransactions(_ transactions: [String]) -> VerifyTransactionsRequest {
		VerifyTransactionsRequest(context: RequestContext(from: self), transactions: transactions)
	}

	/// Returns a request that fetches the list of application themes from the theme store.
	public func themeStore() -> ThemeStoreRequest {
		ThemeStoreRequest(context: RequestContext(from: self))
	}

	/// Returns a request that fetches the details for the specified application theme.
	///
	/// - Parameter appThemeID: The identifier of the application theme.
	///
	/// - Returns: A configured ``ThemeStoreDetailRequest`` ready to be executed.
	public func themeStoreDetail(_ appThemeID: String) -> ThemeStoreDetailRequest {
		ThemeStoreDetailRequest(context: RequestContext(from: self), appThemeID: appThemeID)
	}

	/// Returns a request that deletes a review.
	///
	/// - Parameter reviewIdentity: The identity of the review to delete.
	///
	/// - Returns: A configured ``DeleteReviewRequest`` ready to be executed.
	public func deleteReview(_ reviewIdentity: ReviewIdentity) -> DeleteReviewRequest {
		DeleteReviewRequest(context: RequestContext(from: self), reviewIdentity: reviewIdentity)
	}
}
