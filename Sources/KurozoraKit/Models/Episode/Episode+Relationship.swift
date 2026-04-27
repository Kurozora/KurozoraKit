//
//  Episode+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Episode {
	/// The set of relationships that can be sideloaded alongside an episode detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case seasons
		case shows
		case previousEpisodes = "previousEpisodes"
		case nextEpisodes = "nextEpisodes"
	}
}
