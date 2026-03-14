//
//  KKHTTPMethod.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// The HTTP method used by a ``KKRequest``.
internal enum KKHTTPMethod: String, Sendable {
	/// Retrieve a resource.
	case get = "GET"

	/// Create a new resource.
	case post = "POST"

	/// Replace an existing resource.
	case put = "PUT"

	/// Remove a resource.
	case delete = "DELETE"

	/// Partially update an existing resource.
	case patch = "PATCH"
}
