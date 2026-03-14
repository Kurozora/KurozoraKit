//
//  KurozoraAPIOptions.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// Configuration options for the Kurozora API client.
///
/// `KurozoraAPIOptions` controls transport-level behavior of ``KurozoraKit/KurozoraKit``
/// when it communicates with a custom API endpoint. A default-constructed value is suitable
/// for most use cases; adjust individual properties to enable network logging, change request
/// timeouts, or inject additional HTTP headers.
public struct KurozoraAPIOptions: Sendable {
	/// Log level for network request/response tracing.
	///
	/// - `off`: No network logging.
	/// - `info`: Log request URL, method, and response status code.
	/// - `debug`: Log request URL, method, headers, body, response status code, headers, and body.
	public enum LogLevel: Sendable {
		/// Disable all network logging.
		case off

		/// Log the request URL, HTTP method, and response status code.
		case info

		/// Log the request URL, HTTP method, headers, body, and full response details.
		case debug
	}

	// MARK: - Properties
	/// The log level used for network tracing.
	public var logLevel: LogLevel

	/// Per-request timeout in seconds. Defaults to `60`.
	public var timeout: TimeInterval

	/// Additional HTTP headers that are appended to every request.
	///
	/// Useful for injecting telemetry headers (`X-Correlation-ID`, `X-Request-ID`, ...)
	/// or for testing scenarios where a stub endpoint requires extra identification.
	public var additionalHeaders: [String: String]

	// MARK: - Initializers
	/// Creates a new options instance.
	///
	/// - Parameters:
	///    - logLevel: The log level used for network tracing. Defaults to `.off`.
	///    - timeout: Per-request timeout in seconds. Defaults to `60`.
	///    - additionalHeaders: Additional HTTP headers appended to every request. Defaults to an empty dictionary.
	public init(
		logLevel: LogLevel = .debug,
		timeout: TimeInterval = 60,
		additionalHeaders: [String: String] = [:]
	) {
		self.logLevel = logLevel
		self.timeout = timeout
		self.additionalHeaders = additionalHeaders
	}

	// MARK: - Presets
	/// The default options: logging off, 60s timeout, no additional headers.
	public static let `default` = KurozoraAPIOptions()
}
