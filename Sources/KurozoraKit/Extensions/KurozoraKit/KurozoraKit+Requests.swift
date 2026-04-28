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
	/// Creates a request for the details of a single fetchable resource.
	public func detail<T: Fetchable>(_ identity: T) -> DetailRequest<T> {
		DetailRequest(context: RequestContext(from: self), identity: identity)
	}

	/// Creates a request for the details of multiple fetchable resources.
	public func details<T: Fetchable>(_ identities: [T]) -> BatchDetailRequest<T> {
		BatchDetailRequest(context: RequestContext(from: self), identities: identities)
	}

	// MARK: Typed-Relationship Overloads
	/// Creates a detail request for a show with typed relationships.
	public func detail(_ identity: ShowIdentity, including relationships: [Show.Relationship] = []) -> DetailRequest<ShowIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a game with typed relationships.
	public func detail(_ identity: GameIdentity, including relationships: [Game.Relationship] = []) -> DetailRequest<GameIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a literature with typed relationships.
	public func detail(_ identity: LiteratureIdentity, including relationships: [Literature.Relationship] = []) -> DetailRequest<LiteratureIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a character with typed relationships.
	public func detail(_ identity: CharacterIdentity, including relationships: [Character.Relationship] = []) -> DetailRequest<CharacterIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a person with typed relationships.
	public func detail(_ identity: PersonIdentity, including relationships: [Person.Relationship] = []) -> DetailRequest<PersonIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for an episode with typed relationships.
	public func detail(_ identity: EpisodeIdentity, including relationships: [Episode.Relationship] = []) -> DetailRequest<EpisodeIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a studio with typed relationships.
	public func detail(_ identity: StudioIdentity, including relationships: [Studio.Relationship] = []) -> DetailRequest<StudioIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}

	/// Creates a detail request for a song with typed relationships.
	public func detail(_ identity: SongIdentity, including relationships: [Song.Relationship] = []) -> DetailRequest<SongIdentity> {
		DetailRequest(context: RequestContext(from: self), identity: identity).including(relationships.map(\.rawValue))
	}
}

// MARK: - List
extension KurozoraKit {
	/// Creates a paginated list request for shows.
	public func shows() -> ListRequest<ShowIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.index.endpointValue)
	}

	/// Creates a paginated list request for games.
	public func games() -> ListRequest<GameIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.index.endpointValue)
	}

	/// Creates a paginated list request for literatures.
	public func literatures() -> ListRequest<LiteratureIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.index.endpointValue)
	}

	/// Creates a paginated list request for characters.
	public func characters() -> ListRequest<CharacterIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.index.endpointValue)
	}

	/// Creates a paginated list request for people.
	public func people() -> ListRequest<PersonIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.index.endpointValue)
	}

	/// Creates a paginated list request for songs.
	public func songs() -> ListRequest<SongIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.index.endpointValue)
	}

	/// Creates a paginated list request for studios.
	public func studios() -> ListRequest<StudioIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.index.endpointValue)
	}

	/// Creates a paginated list request for genres.
	public func genres() -> ListRequest<GenreIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Genres.index.endpointValue)
	}

	/// Creates a paginated list request for themes.
	public func themes() -> ListRequest<ThemeIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Themes.index.endpointValue)
	}

	/// Creates a paginated list request for upcoming shows.
	public func upcomingShows() -> ListRequest<ShowIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.upcoming.endpointValue)
	}

	/// Creates a paginated list request for upcoming games.
	public func upcomingGames() -> ListRequest<GameIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.upcoming.endpointValue)
	}

	/// Creates a paginated list request for upcoming literatures.
	public func upcomingLiteratures() -> ListRequest<LiteratureIdentity> {
		ListRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.upcoming.endpointValue)
	}
}

// MARK: - Relationships (Shows)
extension KurozoraKit {
	/// Creates a request for the cast of a show.
	public func cast(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.cast(show).endpointValue)
	}

	/// Creates a request for the characters of a show.
	public func characters(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.characters(show).endpointValue)
	}

	/// Creates a request for the people of a show.
	public func people(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.people(show).endpointValue)
	}

	/// Creates a request for the seasons of a show.
	public func seasons(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<SeasonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.seasons(show).endpointValue)
	}

	/// Creates a request for the songs of a show.
	public func songs(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<ShowSong>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.songs(show).endpointValue)
	}

	/// Creates a request for the studios of a show.
	public func studios(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.studios(show).endpointValue)
	}

	/// Creates a request for the related shows of a show.
	public func relatedShows(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedShows(show).endpointValue)
	}

	/// Creates a request for the related literatures of a show.
	public func relatedLiteratures(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedLiteratures(show).endpointValue)
	}

	/// Creates a request for the related games of a show.
	public func relatedGames(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.relatedGames(show).endpointValue)
	}

	/// Creates a request for the reviews of a show.
	public func reviews(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.reviews(show).endpointValue)
	}

	/// Creates a request for more shows by the same studio.
	public func moreByStudio(for show: ShowIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.moreByStudio(show).endpointValue)
	}
}

// MARK: - Relationships (Games)
extension KurozoraKit {
	/// Creates a request for the cast of a game.
	public func cast(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.cast(game).endpointValue)
	}

	/// Creates a request for the characters of a game.
	public func characters(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.characters(game).endpointValue)
	}

	/// Creates a request for the people of a game.
	public func people(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.people(game).endpointValue)
	}

	/// Creates a request for the studios of a game.
	public func studios(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.studios(game).endpointValue)
	}

	/// Creates a request for the related shows of a game.
	public func relatedShows(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedShows(game).endpointValue)
	}

	/// Creates a request for the related literatures of a game.
	public func relatedLiteratures(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedLiteratures(game).endpointValue)
	}

	/// Creates a request for the related games of a game.
	public func relatedGames(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.relatedGames(game).endpointValue)
	}

	/// Creates a request for the reviews of a game.
	public func reviews(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.reviews(game).endpointValue)
	}

	/// Creates a request for more games by the same studio.
	public func moreByStudio(for game: GameIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.moreByStudio(game).endpointValue)
	}
}

// MARK: - Relationships (Literatures)
extension KurozoraKit {
	/// Creates a request for the cast of a literature.
	public func cast(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<CastIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.cast(literature).endpointValue)
	}

	/// Creates a request for the characters of a literature.
	public func characters(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.characters(literature).endpointValue)
	}

	/// Creates a request for the people of a literature.
	public func people(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.people(literature).endpointValue)
	}

	/// Creates a request for the studios of a literature.
	public func studios(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<StudioIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.studios(literature).endpointValue)
	}

	/// Creates a request for the related shows of a literature.
	public func relatedShows(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedShow>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedShows(literature).endpointValue)
	}

	/// Creates a request for the related literatures of a literature.
	public func relatedLiteratures(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedLiterature>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedLiteratures(literature).endpointValue)
	}

	/// Creates a request for the related games of a literature.
	public func relatedGames(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<RelatedGame>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.relatedGames(literature).endpointValue)
	}

	/// Creates a request for the reviews of a literature.
	public func reviews(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.reviews(literature).endpointValue)
	}

	/// Creates a request for more literatures by the same studio.
	public func moreByStudio(for literature: LiteratureIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.moreByStudio(literature).endpointValue)
	}
}

// MARK: - Relationships (Characters, People, Studios, Songs, Episodes)
extension KurozoraKit {
	/// Creates a request for the people of a character.
	public func people(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<PersonIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.people(character).endpointValue)
	}

	/// Creates a request for the shows of a character.
	public func shows(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.shows(character).endpointValue)
	}

	/// Creates a request for the games of a character.
	public func games(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.games(character).endpointValue)
	}

	/// Creates a request for the literatures of a character.
	public func literatures(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.literatures(character).endpointValue)
	}

	/// Creates a request for the reviews of a character.
	public func reviews(for character: CharacterIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.reviews(character).endpointValue)
	}

	/// Creates a request for the characters of a person.
	public func characters(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<CharacterIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.characters(person).endpointValue)
	}

	/// Creates a request for the shows of a person.
	public func shows(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.shows(person).endpointValue)
	}

	/// Creates a request for the games of a person.
	public func games(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.games(person).endpointValue)
	}

	/// Creates a request for the literatures of a person.
	public func literatures(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.literatures(person).endpointValue)
	}

	/// Creates a request for the reviews of a person.
	public func reviews(for person: PersonIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.reviews(person).endpointValue)
	}

	/// Creates a request for the shows of a studio.
	public func shows(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.shows(studio).endpointValue)
	}

	/// Creates a request for the games of a studio.
	public func games(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.games(studio).endpointValue)
	}

	/// Creates a request for the literatures of a studio.
	public func literatures(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<LiteratureIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.literatures(studio).endpointValue)
	}

	/// Creates a request for the reviews of a studio.
	public func reviews(for studio: StudioIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.reviews(studio).endpointValue)
	}

	/// Creates a request for the shows of a song.
	public func shows(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<ShowIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.shows(song).endpointValue)
	}

	/// Creates a request for the games of a song.
	public func games(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<GameIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.games(song).endpointValue)
	}

	/// Creates a request for the reviews of a song.
	public func reviews(for song: SongIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.reviews(song).endpointValue)
	}

	/// Creates a request for the reviews of an episode.
	public func reviews(for episode: EpisodeIdentity) -> RelationshipRequest<ResourceCollection<Review>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.reviews(episode).endpointValue)
	}

	/// Creates a request for episode suggestions.
	public func suggestions(for episode: EpisodeIdentity) -> RelationshipRequest<ResourceCollection<EpisodeIdentity>> {
		RelationshipRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.suggestions(episode).endpointValue)
	}
}

// MARK: - Search
extension KurozoraKit {
	/// Creates a search request.
	public func search(_ scope: SearchScope, types: [SearchType], query: String) -> SearchRequest {
		SearchRequest(context: RequestContext(from: self), scope: scope, types: types, query: query)
	}
}

// MARK: - Library
extension KurozoraKit {
	/// Creates a request to fetch the authenticated user's library.
	public func library(_ kind: LibraryKind, status: LibraryStatus) -> LibraryRequest {
		LibraryRequest(context: RequestContext(from: self), kind: kind, status: status)
	}

	/// Creates a request to add one or more items to the library.
	public func addToLibrary(_ kind: LibraryKind, status: LibraryStatus, itemIDs: [KurozoraItemID]) -> LibraryAddRequest {
		LibraryAddRequest(context: RequestContext(from: self), kind: kind, status: status, itemIDs: itemIDs)
	}

	/// Creates a request to update one or more library entries.
	public func updateInLibrary(_ kind: LibraryKind, itemIDs: [KurozoraItemID]) -> LibraryUpdateRequest {
		LibraryUpdateRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}

	/// Creates a request to remove one or more items from the library.
	public func removeFromLibrary(_ kind: LibraryKind, itemIDs: [KurozoraItemID]) -> LibraryRemoveRequest {
		LibraryRemoveRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}
}

// MARK: - Rate
extension KurozoraKit {
	/// Creates a request to rate a show.
	public func rate(_ identity: ShowIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Shows.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a game.
	public func rate(_ identity: GameIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Games.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a literature.
	public func rate(_ identity: LiteratureIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Literatures.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a character.
	public func rate(_ identity: CharacterIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Characters.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a person.
	public func rate(_ identity: PersonIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.People.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a song.
	public func rate(_ identity: SongIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Songs.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate an episode.
	public func rate(_ identity: EpisodeIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Episodes.rate(identity).endpointValue, score: score)
	}

	/// Creates a request to rate a studio.
	public func rate(_ identity: StudioIdentity, score: Double) -> RateRequest {
		RateRequest(context: RequestContext(from: self), endpoint: KKEndpoint.Studios.rate(identity).endpointValue, score: score)
	}
}

// MARK: - Favorite & Reminder
extension KurozoraKit {
	/// Creates a request to toggle the favorite status for one or more library items.
	public func toggleFavorite(inLibrary kind: LibraryKind, itemIDs: [KurozoraItemID]) -> FavoriteRequest {
		FavoriteRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}

	/// Creates a request to toggle the reminder status for one or more library items.
	public func toggleReminder(inLibrary kind: LibraryKind, itemIDs: [KurozoraItemID]) -> ReminderRequest {
		ReminderRequest(context: RequestContext(from: self), kind: kind, itemIDs: itemIDs)
	}

	/// The reminder subscription URL for the authenticated user.
	public var reminderSubscriptionURL: URL {
		let path = KKEndpoint.Me.Reminders.download.endpointValue
		let base = self.apiEndpoint.baseURL
		return URL(string: path, relativeTo: URL(string: base))?.absoluteURL
			?? URL(string: base + path)
			?? URL(fileURLWithPath: "")
	}
}

// MARK: - Authentication
extension KurozoraKit {
	/// Creates a request to sign a user in with email and password.
	public func signIn(email: String, password: String) -> SignInRequest {
		SignInRequest(context: RequestContext(from: self), email: email, password: password)
	}

	/// Creates a request to sign in or register an account using Sign in with Apple.
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
	/// Creates a request to register a new user account.
	public func signUp(username: String, emailAddress: String, password: String, profileImage: UIImage? = nil) -> SignUpRequest {
		SignUpRequest(context: RequestContext(from: self), username: username, emailAddress: emailAddress, password: password, profileImage: profileImage)
	}
	#endif

	/// Creates a request to send a password reset link to the given email address.
	public func resetPassword(emailAddress: String) -> ResetPasswordRequest {
		ResetPasswordRequest(context: RequestContext(from: self), emailAddress: emailAddress)
	}

	/// Creates a request to delete the authenticated user's account.
	public func deleteAccount(password: String) -> DeleteAccountRequest {
		DeleteAccountRequest(context: RequestContext(from: self), password: password)
	}

	/// Creates a request to sign the authenticated user out by invalidating the current access token.
	public func signOut() -> SignOutRequest {
		let tokenIdentifier = self.authenticationKey.components(separatedBy: "|")[0]
		return SignOutRequest(context: RequestContext(from: self), accessTokenIdentifier: tokenIdentifier)
	}
}

// MARK: - Profile (Me)
extension KurozoraKit {
	/// Creates a request to fetch the authenticated user's profile details.
	public func profileDetails() -> ProfileDetailsRequest {
		ProfileDetailsRequest(context: RequestContext(from: self))
	}

	#if !os(watchOS)
	/// Creates a request to update the authenticated user's profile information.
	public func updateProfile(_ update: ProfileUpdateRequest) -> UpdateProfileRequest {
		UpdateProfileRequest(context: RequestContext(from: self), update: update)
	}
	#endif

	/// Creates a request to fetch the authenticated user's followers or following list.
	public func myFollowList(_ listType: UsersListType) -> MyFollowListRequest {
		MyFollowListRequest(context: RequestContext(from: self), listType: listType)
	}

	/// Creates a request to fetch the authenticated user's up-next episodes.
	public func upNextEpisodes(for showIdentity: ShowIdentity? = nil) -> UpNextEpisodesRequest {
		UpNextEpisodesRequest(context: RequestContext(from: self), showIdentity: showIdentity)
	}
}

// MARK: - Sessions & Access Tokens
extension KurozoraKit {
	/// Creates a request to fetch the authenticated user's access tokens.
	public func accessTokens() -> AccessTokensRequest {
		AccessTokensRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the details for a given access token.
	public func accessTokenDetail(_ accessToken: String) -> AccessTokenDetailRequest {
		AccessTokenDetailRequest(context: RequestContext(from: self), accessToken: accessToken)
	}

	/// Creates a request to update the current access token with an APN device token.
	public func updateAccessToken(withAPNToken apnDeviceToken: String) -> UpdateAPNTokenRequest {
		let tokenID = self.authenticationKey.components(separatedBy: "|")[0]
		return UpdateAPNTokenRequest(context: RequestContext(from: self), accessTokenID: tokenID, apnDeviceToken: apnDeviceToken)
	}

	/// Creates a request to delete the specified access token from the user's active sessions.
	public func deleteAccessToken(_ accessToken: String) -> DeleteAccessTokenRequest {
		let tokenID = accessToken.components(separatedBy: "|")[0]
		return DeleteAccessTokenRequest(context: RequestContext(from: self), accessTokenID: tokenID)
	}

	/// Creates a request to fetch the authenticated user's sessions.
	public func sessions() -> SessionsRequest {
		SessionsRequest(context: RequestContext(from: self))
	}

	/// Creates a request to delete the specified session from the user's active sessions.
	public func deleteSession(_ sessionIdentity: SessionIdentity) -> DeleteSessionRequest {
		DeleteSessionRequest(context: RequestContext(from: self), sessionIdentity: sessionIdentity)
	}
}

// MARK: - Library Extras
extension KurozoraKit {
	/// Creates a request to clear all items from the authenticated user's library.
	public func clearLibrary(_ kind: LibraryKind, password: String) -> ClearLibraryRequest {
		ClearLibraryRequest(context: RequestContext(from: self), kind: kind, password: password)
	}

	/// Creates a request to import a library file into the authenticated user's library.
	public func importLibrary(_ kind: LibraryKind, service: LibraryImport.Service, behavior: LibraryImport.Behavior, filePath: URL) -> ImportLibraryRequest {
		ImportLibraryRequest(context: RequestContext(from: self), kind: kind, service: service, behavior: behavior, filePath: filePath)
	}

	/// Creates a request to fetch the authenticated user's favorites for the given library kind.
	public func myFavorites(_ kind: LibraryKind) -> MyFavoritesRequest {
		MyFavoritesRequest(context: RequestContext(from: self), kind: kind)
	}

	/// Creates a request to fetch the authenticated user's reminders for the given library kind.
	public func myReminders(_ kind: LibraryKind) -> MyRemindersRequest {
		MyRemindersRequest(context: RequestContext(from: self), kind: kind)
	}
}

// MARK: - Notifications
extension KurozoraKit {
	/// Creates a request to fetch the authenticated user's notifications.
	public func notifications() -> NotificationsRequest {
		NotificationsRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the details of a notification.
	public func notificationDetail(_ identity: any KurozoraItem) -> NotificationDetailRequest {
		NotificationDetailRequest(context: RequestContext(from: self), identity: identity)
	}

	/// Creates a request to update the read status of a notification.
	public func updateNotification(_ notificationID: String, readStatus: ReadStatus) -> UpdateNotificationRequest {
		UpdateNotificationRequest(context: RequestContext(from: self), notificationID: notificationID, readStatus: readStatus)
	}

	/// Creates a request to delete a notification.
	public func deleteNotification(_ identity: any KurozoraItem) -> DeleteNotificationRequest {
		DeleteNotificationRequest(context: RequestContext(from: self), identity: identity)
	}
}

// MARK: - User Relations
extension KurozoraKit {
	/// Creates a request to fetch a user's followers or following list.
	public func followList(forUser userIdentity: UserIdentity, _ listType: UsersListType) -> UserFollowListRequest {
		UserFollowListRequest(context: RequestContext(from: self), userIdentity: userIdentity, listType: listType)
	}

	/// Creates a request to fetch a user's block list.
	public func blockList(forUser userIdentity: UserIdentity) -> UserBlockListRequest {
		UserBlockListRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Creates a request to toggle the follow status for a user.
	public func toggleFollow(_ userIdentity: UserIdentity) -> ToggleFollowRequest {
		ToggleFollowRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Creates a request to toggle the block status for a user.
	public func toggleBlock(_ userIdentity: UserIdentity) -> ToggleBlockRequest {
		ToggleBlockRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Creates a request to fetch a user's favorites filtered by library kind.
	public func favorites(forUser userIdentity: UserIdentity, kind: LibraryKind) -> UserFavoritesRequest {
		UserFavoritesRequest(context: RequestContext(from: self), userIdentity: userIdentity, kind: kind)
	}

	/// Creates a request to fetch a user's library entries with the specified filters.
	public func library(forUser userIdentity: UserIdentity, kind: LibraryKind, status: LibraryStatus) -> UserLibraryRequest {
		UserLibraryRequest(context: RequestContext(from: self), userIdentity: userIdentity, kind: kind, status: status)
	}

	/// Creates a request to fetch the reviews written by a user.
	public func reviews(forUser userIdentity: UserIdentity) -> UserReviewsRequest {
		UserReviewsRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Creates a request to search for users matching a username.
	public func searchUsers(_ username: String) -> SearchUsersRequest {
		SearchUsersRequest(context: RequestContext(from: self), username: username)
	}
}

// MARK: - Feed Messages
extension KurozoraKit {
	/// Creates a request to fetch feed messages for a given user.
	public func feedMessages(forUser userIdentity: UserIdentity) -> UserFeedMessagesRequest {
		UserFeedMessagesRequest(context: RequestContext(from: self), userIdentity: userIdentity)
	}

	/// Creates a request to fetch the authenticated user's feed messages.
	public func myFeedMessages() -> MyFeedMessagesRequest {
		MyFeedMessagesRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the home feed messages.
	public func feedHome() -> FeedHomeRequest {
		FeedHomeRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the explore feed messages.
	public func feedExplore() -> FeedExploreRequest {
		FeedExploreRequest(context: RequestContext(from: self))
	}

	/// Creates a request to post a new feed message.
	public func postFeedMessage(_ message: FeedMessageRequest) -> PostFeedMessageRequest {
		PostFeedMessageRequest(context: RequestContext(from: self), message: message)
	}

	/// Creates a request to fetch the details of a feed message.
	public func feedMessageDetail(_ messageIdentity: FeedMessageIdentity) -> FeedMessageDetailRequest {
		FeedMessageDetailRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Creates a request to fetch the replies of a feed message.
	public func replies(forFeedMessage messageIdentity: FeedMessageIdentity) -> FeedMessageRepliesRequest {
		FeedMessageRepliesRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Creates a request to update a feed message.
	public func updateFeedMessage(_ update: FeedMessageUpdateRequest) -> UpdateFeedMessageRequest {
		UpdateFeedMessageRequest(context: RequestContext(from: self), update: update)
	}

	/// Creates a request to heart or un-heart a feed message.
	public func heartFeedMessage(_ messageIdentity: FeedMessageIdentity) -> HeartFeedMessageRequest {
		HeartFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Creates a request to pin or unpin a feed message.
	public func pinFeedMessage(_ messageIdentity: FeedMessageIdentity) -> PinFeedMessageRequest {
		PinFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}

	/// Creates a request to delete a feed message.
	public func deleteFeedMessage(_ messageIdentity: FeedMessageIdentity) -> DeleteFeedMessageRequest {
		DeleteFeedMessageRequest(context: RequestContext(from: self), messageIdentity: messageIdentity)
	}
}

// MARK: - Watch Status & Season Episodes
extension KurozoraKit {
	/// Creates a request to toggle the watch status of an episode.
	public func updateWatchStatus(forEpisode episodeIdentity: EpisodeIdentity) -> UpdateEpisodeWatchStatusRequest {
		UpdateEpisodeWatchStatusRequest(context: RequestContext(from: self), episodeIdentity: episodeIdentity)
	}

	/// Creates a request to toggle the watch status of a season.
	public func updateWatchStatus(forSeason seasonIdentity: SeasonIdentity) -> UpdateSeasonWatchStatusRequest {
		UpdateSeasonWatchStatusRequest(context: RequestContext(from: self), seasonIdentity: seasonIdentity)
	}

	/// Creates a request to fetch the episodes for a given season.
	public func episodes(for seasonIdentity: SeasonIdentity) -> SeasonEpisodesRequest {
		SeasonEpisodesRequest(context: RequestContext(from: self), seasonIdentity: seasonIdentity)
	}
}

// MARK: - Browse
extension KurozoraKit {
	/// Creates a request to fetch the explore page content.
	public func explore() -> ExploreRequest {
		ExploreRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the content of a specific explore category.
	public func exploreCategory(_ categoryIdentity: ExploreCategoryIdentity) -> ExploreCategoryRequest {
		ExploreCategoryRequest(context: RequestContext(from: self), categoryIdentity: categoryIdentity)
	}

	/// Creates a request to fetch the schedule for a given type and date.
	public func schedule(for type: KKScheduleType, in date: Date) -> ScheduleRequest {
		ScheduleRequest(context: RequestContext(from: self), type: type, date: date)
	}

	/// Creates a request to fetch the list of available recaps.
	public func recaps() -> RecapsRequest {
		RecapsRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the recap for a specific year and month.
	public func recap(year: String, month: String) -> RecapDetailRequest {
		RecapDetailRequest(context: RequestContext(from: self), year: year, month: month)
	}

	/// Creates a request for search suggestions matching the given query.
	public func searchSuggestions(_ scope: SearchScope, types: [SearchType], query: String) -> SearchSuggestionsRequest {
		SearchSuggestionsRequest(context: RequestContext(from: self), scope: scope, types: types, query: query)
	}
}

// MARK: - Misc
extension KurozoraKit {
	/// Creates a request to fetch the service meta information.
	public func info() -> InfoRequest {
		InfoRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the app settings.
	public func settings() -> SettingsRequest {
		SettingsRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch a collection of random images.
	public func randomImages(of kind: MediaKind, from collection: MediaCollection) -> RandomImagesRequest {
		RandomImagesRequest(context: RequestContext(from: self), kind: kind, collection: collection)
	}

	/// Creates a request to fetch the latest Privacy Policy.
	public func privacyPolicy() -> PrivacyPolicyRequest {
		PrivacyPolicyRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the latest Terms of Use.
	public func termsOfUse() -> TermsOfUseRequest {
		TermsOfUseRequest(context: RequestContext(from: self))
	}

	/// Creates a request to verify a transaction receipt.
	public func verifyReceipt(_ receipt: String) -> VerifyReceiptRequest {
		VerifyReceiptRequest(context: RequestContext(from: self), receipt: receipt)
	}

	/// Creates a request to fetch the list of app themes from the theme store.
	public func themeStore() -> ThemeStoreRequest {
		ThemeStoreRequest(context: RequestContext(from: self))
	}

	/// Creates a request to fetch the details for a specific app theme.
	public func themeStoreDetail(_ appThemeID: String) -> ThemeStoreDetailRequest {
		ThemeStoreDetailRequest(context: RequestContext(from: self), appThemeID: appThemeID)
	}

	/// Creates a request to delete a review.
	public func deleteReview(_ reviewIdentity: ReviewIdentity) -> DeleteReviewRequest {
		DeleteReviewRequest(context: RequestContext(from: self), reviewIdentity: reviewIdentity)
	}
}
