//
//  ReSharesSortType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/04/2026.
//  MIT License
//

import Foundation

/// The sort order for the quote and re-share activity endpoints.
public enum ReSharesSortType: String, Sendable, CaseIterable {
	/// The top-ranked re-shares first.
	case top

	/// The most recent re-shares first.
	case recent

	/// The default sort.
	public static let `default`: ReSharesSortType = .recent

	/// The query value sent to the server.
	internal var queryValue: String? {
		switch self {
		case .top:
			return self.rawValue
		case .recent:
			return nil
		}
	}
}
