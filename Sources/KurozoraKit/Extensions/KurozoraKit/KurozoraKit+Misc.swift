//
//  KurozoraKit+Misc.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 9/12/2022.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the service meta information.
	///
	/// - Returns: A ``MetaResponse`` with the meta information.
	public func getInfo() async throws -> MetaResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<MetaResponse>(
			path: KKEndpoint.Misc.info.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the app settings used to enable additional features.
	///
	/// - Returns: A ``SettingsResponse`` with the app settings.
	public func getSettings() async throws -> SettingsResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<SettingsResponse>(
			path: KKEndpoint.Misc.settings.endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
