//
//  KKNetworkClient.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// The networking client that executes HTTP requests for KurozoraKit.
///
/// Wraps a `URLSession` and exposes a single ``send(_:)`` method that decodes
/// success responses or throws a ``KKAPIError`` for any failure.
internal struct KKNetworkClient: Sendable {
	// MARK: - Properties
	private let baseURL: URL
	private let session: URLSession
	private let decoder: JSONDecoder
	private let logger: KKLogger
	private let additionalHeaders: [String: String]

	// MARK: - Initializers
	init(baseURL: String, options: KurozoraAPIOptions = .default) {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = options.timeout
		configuration.timeoutIntervalForResource = options.timeout * 2
		self.init(baseURL: baseURL, session: URLSession(configuration: configuration), options: options)
	}

	/// Designated initializer. Accepts a pre-configured `URLSession`, used by
	/// tests to inject a `MockURLProtocol`-backed session.
	init(baseURL: String, session: URLSession, options: KurozoraAPIOptions = .default) {
		// Trust KurozoraAPI.baseURL to produce a valid URL string. If it doesn't,
		// a missing `/` will trip here and we want to know immediately.
		guard let url = URL(string: baseURL) else {
			preconditionFailure("KurozoraKit: invalid baseURL '\(baseURL)'")
		}
		self.baseURL = url
		self.session = session

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		self.decoder = decoder

		self.logger = KKLogger(level: options.logLevel)
		self.additionalHeaders = options.additionalHeaders
	}

	// MARK: - Send
	/// Executes the given request and decodes its response.
	///
	/// - Parameter request: The request descriptor.
	/// - Returns: A decoded value of type `Response`.
	/// - Throws: ``KKAPIError`` for any failure — server, transport, or decoding.
	func send<Response: Decodable & Sendable>(_ request: KKRequest<Response>) async throws -> Response {
		let urlRequest = try self.buildURLRequest(from: request)
		self.logger.logRequest(urlRequest)

		let data: Data
		let response: URLResponse
		do {
			(data, response) = try await self.session.data(for: urlRequest)
		} catch {
			self.logger.logError(error, request: urlRequest)
			throw KKAPIError(transport: error, request: urlRequest)
		}

		self.logger.logResponse(response, data: data)

		guard let http = response as? HTTPURLResponse else {
			throw KKAPIError(message: "The server returned a non-HTTP response.", response: nil, request: urlRequest)
		}

		if (200..<300).contains(http.statusCode) {
			do {
				return try self.decoder.decode(Response.self, from: data)
			} catch {
				throw KKAPIError(decoding: error, response: http, request: urlRequest)
			}
		}

		throw KKAPIError(responseData: data, response: http, request: urlRequest, decoder: self.decoder)
	}

	// MARK: - URLRequest construction
	private func buildURLRequest<Response>(from request: KKRequest<Response>) throws -> URLRequest {
		let baseResolved = Self.resolveURL(path: request.path, base: self.baseURL)
		let finalURL = Self.appendQuery(request.query, to: baseResolved)

		var urlRequest = URLRequest(url: finalURL)
		urlRequest.httpMethod = request.method.rawValue

		// Apply headers in order: additional (from options) → request-specific.
		// Later values win, matching caller expectations.
		for (key, value) in self.additionalHeaders {
			urlRequest.setValue(value, forHTTPHeaderField: key)
		}
		for (key, value) in request.headers {
			urlRequest.setValue(value, forHTTPHeaderField: key)
		}

		switch request.body {
		case .none:
			break

		case .formURLEncoded(let parameters):
			let encoded = KKFormURLEncoder.encode(parameters)
			urlRequest.httpBody = encoded.data(using: .utf8)
			// Ensure the content type reflects the body we actually sent.
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

		case .multipart(let formData, let parameters):
			// Multipart must own the Content-Type header so the boundary is correct.
			urlRequest.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
			urlRequest.httpBody = formData.encode(parameters: parameters)

		case .json(let data):
			urlRequest.httpBody = data
			urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		}

		return urlRequest
	}

	// MARK: - URL resolution
	/// Resolves a request path against the client's base URL.
	///
	/// If `path` is already an absolute URL (contains a scheme), it is used as-is.
	/// Otherwise it is resolved relative to `base`.
	private static func resolveURL(path: String, base: URL) -> URL {
		if let absolute = URL(string: path), absolute.scheme != nil {
			return absolute
		}
		return URL(string: path, relativeTo: base)?.absoluteURL
			?? base.appendingPathComponent(path)
	}

	/// Appends query parameters to `url`, preserving any existing query items.
	private static func appendQuery(_ query: [String: Any]?, to url: URL) -> URL {
		guard let query = query, !query.isEmpty else { return url }
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return url }

		var items = components.queryItems ?? []
		items.append(contentsOf: KKFormURLEncoder.queryItems(from: query))
		components.queryItems = items
		return components.url ?? url
	}
}
