//
//  KKLogger.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation
import os.log

/// Lightweight wrapper around `os.Logger` used for network tracing.
///
/// The logger honors the configured ``KurozoraAPIOptions/LogLevel``:
/// - `.off`: silent.
/// - `.info`: request URL/method and response status code.
/// - `.debug`: full request (headers + body) and response (status + headers + body).
///
/// All output is routed through `os.Logger` with subsystem `app.kurozora.KurozoraKit`
/// and category `Networking`, which keeps it discoverable in Console.app while
/// respecting the privacy classification of the underlying `Logger` APIs.
internal struct KKLogger: Sendable {
	// MARK: - Properties
	private let level: KurozoraAPIOptions.LogLevel
	private let logger = Logger(subsystem: "app.kurozora.KurozoraKit", category: "Networking")

	// MARK: - Initializer
	init(level: KurozoraAPIOptions.LogLevel) {
		self.level = level
	}

	// MARK: - Request / Response
	func logRequest(_ request: URLRequest) {
		switch self.level {
		case .off:
			return
		case .info:
			self.logger.info("➡️ \(request.httpMethod ?? "?", privacy: .public) \(request.url?.absoluteString ?? "<no url>", privacy: .public)")
		case .debug:
			self.logger.debug("➡️ \(request.httpMethod ?? "?", privacy: .public) \(request.url?.absoluteString ?? "<no url>", privacy: .public)")
			if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
				self.logger.debug("   headers: \(headers, privacy: .private)")
			}
			if let body = request.httpBody, let string = String(data: body, encoding: .utf8) {
				self.logger.debug("   body: \(string, privacy: .private)")
			}
		}
	}

	func logResponse(_ response: URLResponse?, data: Data) {
		guard self.level != .off else { return }

		let status = (response as? HTTPURLResponse)?.statusCode ?? -1
		let url = response?.url?.absoluteString ?? "<no url>"

		switch self.level {
		case .off:
			return
		case .info:
			self.logger.info("⬅️ \(status, privacy: .public) \(url, privacy: .public)")
		case .debug:
			self.logger.debug("⬅️ \(status, privacy: .public) \(url, privacy: .public)")
			if let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: String], !headers.isEmpty {
				self.logger.debug("   headers: \(headers, privacy: .private)")
			}
			if let string = String(data: data, encoding: .utf8), !string.isEmpty {
				self.logger.debug("   body: \(string, privacy: .private)")
			}
		}
	}

	func logError(_ error: Error, request: URLRequest?) {
		guard self.level != .off else { return }
		let url = request?.url?.absoluteString ?? "<no url>"
		self.logger.error("❌ transport error: \(error.localizedDescription, privacy: .public) [\(url, privacy: .public)]")
	}
}
