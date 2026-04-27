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
/// success responses or throws a ``APIError`` for any failure.
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
	///
	/// - Returns: A decoded value of type `Response`.
	///
	/// - Throws: ``APIError`` for any failure — server, transport, or decoding.
	func send<Response: Decodable & Sendable>(_ request: KKRequest<Response>) async throws -> Response {
		let urlRequest = try self.buildURLRequest(from: request)
		self.logger.logRequest(urlRequest)

		let data: Data
		let response: URLResponse
		do {
			(data, response) = try await self.fetchData(for: urlRequest)
		} catch {
			self.logger.logError(error, request: urlRequest)
			throw APIError(transport: error, request: urlRequest)
		}

		self.logger.logResponse(response, data: data)

		guard let http = response as? HTTPURLResponse else {
			throw APIError(message: "The server returned a non-HTTP response.", response: nil, request: urlRequest)
		}

		if (200..<300).contains(http.statusCode) {
			do {
				return try self.decoder.decode(Response.self, from: data)
			} catch {
				throw APIError(decoding: error, response: http, request: urlRequest)
			}
		}

		throw APIError(responseData: data, response: http, request: urlRequest, decoder: self.decoder)
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

	// MARK: - Data fetching
	/// Performs `urlRequest` and returns its response body and metadata.
	///
	/// - Parameter urlRequest: The request to perform.
	///
	/// - Returns: The response body and its `URLResponse`.
	///
	/// - Throws: Any error reported by the underlying `URLSessionDataTask`,
	///   or `URLError(.badServerResponse)` if neither data nor an error is delivered.
	private func fetchData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
		let taskHandle = URLSessionTaskHandle()
		return try await withTaskCancellationHandler {
			try await withCheckedThrowingContinuation { continuation in
				let task = self.session.dataTask(with: urlRequest) { data, response, error in
					if let error {
						continuation.resume(throwing: error)
					} else if let data, let response {
						continuation.resume(returning: (data, response))
					} else {
						continuation.resume(throwing: URLError(.badServerResponse))
					}
				}
				if taskHandle.adopt(task) {
					task.resume()
				}
			}
		} onCancel: {
			taskHandle.cancel()
		}
	}
}

// MARK: - URLSessionTaskHandle
/// Thread-safe holder for a `URLSessionTask` shared between a continuation
/// and a task cancellation handler.
private final class URLSessionTaskHandle: @unchecked Sendable {
	// MARK: - Properties
	private let lock = NSLock()
	private var task: URLSessionTask?
	private var isCancelled = false

	// MARK: - Functions
	/// Stores the task and reports whether the caller should resume it.
	///
	/// - Parameter task: The task to adopt.
	///
	/// - Returns: `true` if the caller should resume the task; `false` if the
	///   handle has already been cancelled, in which case the task has been
	///   cancelled in place.
	func adopt(_ task: URLSessionTask) -> Bool {
		self.lock.lock()
		defer { self.lock.unlock() }
		if self.isCancelled {
			task.cancel()
			return false
		}
		self.task = task
		return true
	}

	/// Cancels the held task, or arms the handle so the next ``adopt(_:)``
	/// cancels its task before returning.
	func cancel() {
		self.lock.lock()
		let task = self.task
		self.isCancelled = true
		self.lock.unlock()
		task?.cancel()
	}
}
