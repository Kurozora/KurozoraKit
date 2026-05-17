//
//  SeasonOfYear.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

/// The list of available seasons of the year.
///
/// - Tag: SeasonOfYear
public enum SeasonOfYear: Int, CaseIterable, Sendable {
	/// Indicates the season is winter.
	///
	/// - Tag: SeasonOfYear-winter
	case winter = 0

	/// Indicates the season is spring.
	///
	/// - Tag: SeasonOfYear-spring
	case spring

	/// Indicates the season is summer.
	///
	/// - Tag: SeasonOfYear-summer
	case summer

	/// Indicates the season is fall.
	///
	/// - Tag: SeasonOfYear-fall
	case fall
}
