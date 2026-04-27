//
//  ThemeStoreDetailRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the details for a specific app theme.
public struct ThemeStoreDetailRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let appThemeID: String

	// MARK: - Initializers
	internal init(context: RequestContext, appThemeID: String) {
		self.context = context
		self.appThemeID = appThemeID
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<AppTheme> {
		let request = KKRequest<ResourceCollection<AppTheme>>(
			path: KKEndpoint.ThemeStore.details(self.appThemeID).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
