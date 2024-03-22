//
//  ReviewRelationships.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/07/2023.
//

extension Review {
	/// A root object that stores information about review relationships, such as the user that belong to it.
	public struct Relationships: Codable {
		// MARK: - Properties
		/// The shows belonging to the rating.
		public let shows: ShowResponse?

		/// The games belonging to the rating.
		public let games: GameResponse?

		/// The literature belonging to the rating.
		public let literatures: LiteratureResponse?

		/// The episodes belonging to the rating.
		public let episodes: EpisodeResponse?

		/// The songs belonging to the rating.
		public let songs: SongResponse?

		/// The characters belonging to the rating.
		public let characters: CharacterResponse?

		/// The people belonging to the rating.
		public let people: PersonResponse?

		/// The studios belonging to the rating.
		public let studios: StudioResponse?

		/// The users belonging to the review.
		public let users: UserResponse?
	}
}
