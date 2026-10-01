//
//  EpisodeFillerKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/10/2026.
//  MIT License
//

/// The set of available episode filler kinds.
///
/// - `mangaCanon`: the episode is adapted from the source manga.
/// - `animeCanon`: the episode is canon to the anime but original to it.
/// - `mixedCanonFiller`: the episode is part canon and part filler.
/// - `filler`: the episode is non-canon and can be skipped.
///
/// - Tag: EpisodeFillerKind
public enum EpisodeFillerKind: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Indicates the episode is adapted from the source manga.
	case mangaCanon = 0

	/// Indicates the episode is canon to the anime but original to it.
	case animeCanon = 1

	/// Indicates the episode is part canon and part filler.
	case mixedCanonFiller = 2

	/// Indicates the episode is non-canon and can be skipped.
	case filler = 3
}
