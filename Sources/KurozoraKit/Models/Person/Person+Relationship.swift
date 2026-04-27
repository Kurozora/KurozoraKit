//
//  Person+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Person {
	/// The set of relationships that can be sideloaded alongside a person detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case characters
		case shows
		case games
		case literatures
	}
}
