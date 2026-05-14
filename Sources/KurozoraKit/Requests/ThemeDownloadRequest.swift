//
//  ThemeDownloadRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/05/2026.
//  MIT License
//

import Foundation

/// A request that downloads the binary file for a specific app theme.
public struct ThemeDownloadRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let appThemeID: KurozoraItemID
	private let progressHandler: (@MainActor @Sendable (Double) -> Void)?

	// MARK: - Initializers
	internal init(
		context: RequestContext,
		appThemeID: KurozoraItemID,
		progressHandler: (@MainActor @Sendable (Double) -> Void)? = nil
	) {
		self.context = context
		self.appThemeID = appThemeID
		self.progressHandler = progressHandler
	}

	// MARK: - Builders
	/// Attaches a byte-progress callback to the request.
	///
	/// - Parameter handler: A closure invoked on the main actor with values in `0...1`.
	///
	/// - Returns: A new request configured to forward progress updates to `handler`.
	public func onProgress(_ handler: @escaping @MainActor @Sendable (Double) -> Void) -> ThemeDownloadRequest {
		return ThemeDownloadRequest(context: self.context, appThemeID: self.appThemeID, progressHandler: handler)
	}

	// MARK: - Execution
	/// Executes the request and returns the raw bytes of the theme file.
	///
	/// - Returns: The theme file contents, suitable for writing directly to disk.
	public func response() async throws -> Data {
		if let progressHandler = self.progressHandler {
			return try await self.context.client.download(
				path: KKEndpoint.ThemeStore.download(self.appThemeID).endpointValue,
				headers: self.context.headers,
				onProgress: progressHandler
			)
		}

		return try await self.context.client.download(
			path: KKEndpoint.ThemeStore.download(self.appThemeID).endpointValue,
			headers: self.context.headers
		)
	}
}
