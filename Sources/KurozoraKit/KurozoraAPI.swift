//
//  KurozoraAPI.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/08/2024.
//  MIT License
//

import Foundation

/// The set of possible API endpoints for the Kurozora API.
///
/// - `v1`: The endpoint for the Kurozora API version 1.
/// - `custom`: A custom URL for the Kurozora API.
///
/// - Tag: KurozoraAPI
public enum KurozoraAPI: Equatable, Sendable {
	// MARK: - Cases
	/// The endpoint for the Kurozora API version 1.
	case v1

	/// A custom URL for the Kurozora API, with optional client-level configuration overrides.
	case custom(_ url: String, _ options: KurozoraAPIOptions? = nil)

	// MARK: - Properties
	/// All cases of `KurozoraAPI`.
	public static let allCases: [KurozoraAPI] = [.v1]

	/// The base URL for the API.
	public var baseURL: String {
		switch self {
		case .v1:
			return "https://api.kurozora.app/v1/"
		case .custom(let url, _):
			return url
		}
	}

	/// The configuration options applied when building a network client for this endpoint.
	public var options: KurozoraAPIOptions {
		switch self {
		case .v1:
			return .default
		case .custom(_, let options):
			return options ?? .default
		}
	}

	// MARK: - Functions
	public static func == (lhs: KurozoraAPI, rhs: KurozoraAPI) -> Bool {
		switch (lhs, rhs) {
		case (.v1, .v1):
			return true
		case (.custom(let lhsURL, _), .custom(let rhsURL, _)):
			return lhsURL == rhsURL
		default:
			return false
		}
	}
}
