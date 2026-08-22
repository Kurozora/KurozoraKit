//
//  TrailerSort.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/08/2026.
//  MIT License
//

/// The list of available trailer sort orders.
///
/// - Tag: TrailerSort
public enum TrailerSort: Int, CaseIterable, Sendable {
	/// Indicates the trailers are ordered by the most recently added title.
	///
	/// - Tag: TrailerSort-justAdded
	case justAdded = 0

	/// Indicates the trailers are ordered by the most viewed title.
	///
	/// - Tag: TrailerSort-mostPopular
	case mostPopular
}
