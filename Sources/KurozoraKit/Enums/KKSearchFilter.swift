//
//  KKSearchFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

/// A type-safe wrapper that pairs a search resource type with its corresponding filter.
///
/// Use `KKSearchFilter` to attach filter parameters to a search request. Each case
/// carries the filter struct appropriate for that resource type.
public enum KKSearchFilter {
	/// Filter results to app themes matching the given criteria.
	case appTheme(_ filter: AppThemeFilter)

	/// Filter results to characters matching the given criteria.
	case character(_ filter: CharacterFilter)

	/// Filter results to episodes matching the given criteria.
	case episode(_ filter: EpisodeFilter)

	/// Filter results to games matching the given criteria.
	case game(_ filter: GameFilter)

	/// Filter results to literature matching the given criteria.
	case literature(_ filter: LiteratureFilter)

	/// Filter results to people matching the given criteria.
	case person(_ filter: PersonFilter)

	/// Filter results to shows matching the given criteria.
	case show(_ filter: ShowFilter)

	/// Filter results to songs matching the given criteria.
	case song(_ filter: SongFilter)

	/// Filter results to studios matching the given criteria.
	case studio(_ filter: StudioFilter)

	/// Filter results to users matching the given criteria.
	case user(_ filter: UserFilter)
}
