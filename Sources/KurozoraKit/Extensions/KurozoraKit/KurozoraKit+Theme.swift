//
//  KurozoraKit+Theme.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the list of themes.
	///
	/// - Returns: A ``ThemeResponse`` with the list of themes.
	public func getThemes() async throws -> ThemeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ThemeResponse>(
			path: KKEndpoint.Themes.index.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the theme details for the given theme identity.
	///
	/// - Parameter themeIdentity: The identity of the theme to fetch.
	///
	/// - Returns: A ``ThemeResponse`` with the theme details.
	public func getDetails(forTheme themeIdentity: ThemeIdentity) async throws -> ThemeResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ThemeResponse>(
			path: KKEndpoint.Themes.details(themeIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
