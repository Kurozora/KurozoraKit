//
//  Studio+Relationship.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension Studio {
	/// The set of relationships that can be sideloaded alongside a studio detail fetch.
	public enum Relationship: String, CaseIterable, Sendable {
		case predecessors
		case successors
		case shows
		case games
		case literatures
	}
}
