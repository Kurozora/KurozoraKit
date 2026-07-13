//
//  KKConditionalResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/07/2026.
//  MIT License
//

/// The outcome of a conditional request validated with `If-None-Match`.
public enum KKConditionalResponse<Response: Sendable>: Sendable {
	/// A decoded response and its entity tag.
	case modified(Response, etag: String?)

	/// The state matches the sent entity tag.
	case notModified
}
