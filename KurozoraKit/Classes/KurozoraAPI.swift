//
//  KurozoraAPI.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/08/2024.
//

import TRON

/// The set of possible API endpoints for the Kurozora API.
///
/// - `v1`: The endpoint for the Kurozora API version 1.
/// - `custom`: A custom URL for the Kurozora API.
///
/// - Tag: KurozoraAPI
public enum KurozoraAPI {
	// MARK: - Cases
	/// The endpoint for the Kurozora API version 1.
	case v1

	/// A custom URL for the Kurozora API.
	case custom(_ url: String, _ plugin: [Plugin]? = nil)

	// MARK: - Properties
	/// The base URL for the API.
	var baseURL: String {
		switch self {
		case .v1:
			return "https://kurozora.app/api/v1/"
		case .custom(let url, _):
			return url
		}
	}
}
