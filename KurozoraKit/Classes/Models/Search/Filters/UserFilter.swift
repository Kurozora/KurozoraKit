//
//  UserFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//

import Foundation

public struct UserFilter {
	public init() {	}
}

// MARK: - Filterable
extension UserFilter: Filterable {
	func toFilterArray() -> [String: Any?] {
		return [:]
	}
}
