//
//  ChartKind.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 02/08/2026.
//  MIT License
//

/// The list of available top chart kinds.
///
/// - Tag: ChartKind
public enum ChartKind: Int, CaseIterable, Sendable {
	/// Indicates the chart is of the `shows` kind.
	///
	/// - Tag: ChartKind-shows
	case shows = 0

	/// Indicates the chart is of the `characters` kind.
	///
	/// - Tag: ChartKind-characters
	case characters

	/// Indicates the chart is of the `episodes` kind.
	///
	/// - Tag: ChartKind-episodes
	case episodes

	/// Indicates the chart is of the `games` kind.
	///
	/// - Tag: ChartKind-games
	case games

	/// Indicates the chart is of the `literatures` kind.
	///
	/// - Tag: ChartKind-literatures
	case literatures

	/// Indicates the chart is of the `people` kind.
	///
	/// - Tag: ChartKind-people
	case people

	/// Indicates the chart is of the `songs` kind.
	///
	/// - Tag: ChartKind-songs
	case songs

	/// Indicates the chart is of the `studios` kind.
	///
	/// - Tag: ChartKind-studios
	case studios

	// MARK: - Properties
	/// The URL path prefix used to refer to this chart kind.
	public var pathPrefix: String {
		switch self {
		case .shows:
			return "anime"
		case .characters:
			return "characters"
		case .episodes:
			return "episodes"
		case .games:
			return "games"
		case .literatures:
			return "manga"
		case .people:
			return "people"
		case .songs:
			return "songs"
		case .studios:
			return "studios"
		}
	}
}
