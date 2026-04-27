//
//  Song+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Song {
	/// The set of relationships that can be sideloaded alongside a song detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case shows
		case games
	}
}
