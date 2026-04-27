//
//  SearchScope.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 07/06/2022.
//  MIT License
//

/// The list of available search scopes.
///
/// - `kurozora`: searches in the Kurozora catalog.
/// - `library`: searches in the user's library.
///
/// - Tag: SearchScope
public enum SearchScope: Int, CaseIterable, Sendable {
	// MARK: - Cases
	/// Searches in the Kurozora catalog.
	///
	/// - Tag: SearchScope-kurozora
	case kurozora = 0

	/// Searches in the user's library list.
	///
	/// - Tag: SearchScope-library
	case library

	// MARK: - Properties
	/// The query value of a search scope.
	internal var queryValue: String {
		switch self {
		case .kurozora:
			return "kurozora"
		case .library:
			return "library"
		}
	}
}
