//
//  Game+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Game {
	/// The set of relationships that can be sideloaded alongside a game detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case cast
		case characters
		case people
		case relatedShows = "relatedShows"
		case relatedGames = "relatedGames"
		case relatedLiteratures = "relatedLiteratures"
		case songs
		case staff
		case studios
	}
}
