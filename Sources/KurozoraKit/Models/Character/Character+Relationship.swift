//
//  Character+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Character {
	/// The set of relationships that can be sideloaded alongside a character detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case people
		case shows
		case games
		case literatures
	}
}
