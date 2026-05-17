//
//  BrowseSeasonType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

/// The list of available browse season types.
///
/// - Tag: BrowseSeasonType
public enum BrowseSeasonType: Int, CaseIterable, Sendable {
	/// Indicates the browse season is of the `shows` type.
	///
	/// - Tag: BrowseSeasonType-shows
	case shows = 0

	/// Indicates the browse season is of the `literatures` type.
	///
	/// - Tag: BrowseSeasonType-literatures
	case literatures

	/// Indicates the browse season is of the `games` type.
	///
	/// - Tag: BrowseSeasonType-games
	case games

	// MARK: - Properties
	/// The URL path prefix used to refer to this browse season type.
	public var pathPrefix: String {
		switch self {
		case .shows:
			return "anime"
		case .literatures:
			return "manga"
		case .games:
			return "games"
		}
	}
}
