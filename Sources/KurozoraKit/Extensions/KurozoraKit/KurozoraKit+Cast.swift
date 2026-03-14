//
//  KurozoraKit+Cast.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/02/2022.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the show cast details for the given cast identity.
	///
	/// - Parameter castIdentity: The identity of the show cast to fetch.
	///
	/// - Returns: A ``CastResponse`` with the cast details.
	public func getDetails(forShowCast castIdentity: CastIdentity) async throws -> CastResponse {
		let request = KKRequest<CastResponse>(
			path: KKEndpoint.Cast.showCast(castIdentity).endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the literature cast details for the given cast identity.
	///
	/// - Parameter castIdentity: The identity of the literature cast to fetch.
	///
	/// - Returns: A ``CastResponse`` with the cast details.
	public func getDetails(forLiteratureCast castIdentity: CastIdentity) async throws -> CastResponse {
		let request = KKRequest<CastResponse>(
			path: KKEndpoint.Cast.literatureCast(castIdentity).endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the game cast details for the given cast identity.
	///
	/// - Parameter castIdentity: The identity of the game cast to fetch.
	///
	/// - Returns: A ``CastResponse`` with the cast details.
	public func getDetails(forGameCast castIdentity: CastIdentity) async throws -> CastResponse {
		let request = KKRequest<CastResponse>(
			path: KKEndpoint.Cast.gameCast(castIdentity).endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}
}
