//
//  SongFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying songs.
///
/// This filter is currently a placeholder with no configurable parameters.
public struct SongFilter {
	/// Create a song filter.
	public init() {	}
}

// MARK: - Filterable
extension SongFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [:]
	}
}
