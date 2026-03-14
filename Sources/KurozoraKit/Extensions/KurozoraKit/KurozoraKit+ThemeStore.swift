//
//  KurozoraKit+AppTheme.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of app themes from the theme store.
	///
	/// - Returns: An ``AppThemeResponse`` with the list of app themes.
	public func getThemeStore() async throws -> AppThemeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<AppThemeResponse>(
			path: KKEndpoint.ThemeStore.index.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the app theme details for the given app theme identifier.
	///
	/// - Parameter appThemeID: The identifier of the app theme to fetch.
	///
	/// - Returns: An ``AppThemeResponse`` with the app theme details.
	public func getDetails(forAppThemeID appThemeID: String) async throws -> AppThemeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<AppThemeResponse>(
			path: KKEndpoint.ThemeStore.details(appThemeID).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
