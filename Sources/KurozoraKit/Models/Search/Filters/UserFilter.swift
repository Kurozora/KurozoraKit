//
//  UserFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying users.
///
/// This filter is currently a placeholder with no configurable parameters.
public struct UserFilter {
	/// Create a user filter.
	public init() {	}
}

// MARK: - Filterable
extension UserFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [:]
	}
}
