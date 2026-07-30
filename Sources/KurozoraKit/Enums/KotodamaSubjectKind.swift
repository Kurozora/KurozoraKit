//
//  KotodamaSubjectKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

/// The set of available Kotodama subject kinds.
///
/// - `shows`: the answer belongs to a show.
/// - `literatures`: the answer belongs to a literature.
/// - `games`: the answer belongs to a game.
/// - `characters`: the answer belongs to a character.
/// - `people`: the answer belongs to a person.
/// - `studios`: the answer belongs to a studio.
/// - `songs`: the answer belongs to a song.
///
/// - Tag: KotodamaSubjectKind
public enum KotodamaSubjectKind: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Indicates the answer belongs to a show.
	case shows

	/// Indicates the answer belongs to a literature.
	case literatures

	/// Indicates the answer belongs to a game.
	case games

	/// Indicates the answer belongs to a character.
	case characters

	/// Indicates the answer belongs to a person.
	case people

	/// Indicates the answer belongs to a studio.
	case studios

	/// Indicates the answer belongs to a song.
	case songs
}
