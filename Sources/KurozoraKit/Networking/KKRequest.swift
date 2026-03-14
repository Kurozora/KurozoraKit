//
//  KKRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// A request descriptor consumed by ``KKNetworkClient/send(_:)``.
///
/// `KKRequest` is a plain value type that bundles everything needed to build a
/// `URLRequest`: URL (relative or absolute), HTTP method, headers, an optional
/// query dictionary, and a typed body. The generic `Response` parameter is the
/// `Decodable` type the network client decodes on success.
///
/// The type is intentionally not declared `Sendable` — request values are
/// constructed and consumed synchronously inside a single call to
/// `KKNetworkClient.send(_:)` before any suspension, so they never cross an
/// isolation boundary.
internal struct KKRequest<Response: Decodable & Sendable> {
	/// The body of an HTTP request.
	enum Body {
		/// No body (typical for `GET` and `DELETE` without parameters).
		case none

		/// An `application/x-www-form-urlencoded` body.
		case formURLEncoded([String: Any])

		/// A `multipart/form-data` body with optional text parameters.
		case multipart(KKMultipartFormData, parameters: [String: Any])

		/// A pre-encoded `application/json` body.
		case json(Data)
	}

	// MARK: - Properties
	/// The request path. May be a path relative to the client's base URL
	/// (e.g. `"legal/privacy-policy"`) or an absolute URL such as a pagination
	/// cursor returned by a previous response.
	let path: String

	/// The HTTP method.
	let method: KKHTTPMethod

	/// Request-specific headers, merged on top of the client's base headers.
	let headers: [String: String]

	/// Query-string parameters. Encoded using ``KKFormURLEncoder`` semantics.
	let query: [String: Any]?

	/// The request body.
	let body: Body

	// MARK: - Initializer
	init(
		path: String,
		method: KKHTTPMethod,
		headers: [String: String] = [:],
		query: [String: Any]? = nil,
		body: Body = .none
	) {
		self.path = path
		self.method = method
		self.headers = headers
		self.query = query
		self.body = body
	}
}
