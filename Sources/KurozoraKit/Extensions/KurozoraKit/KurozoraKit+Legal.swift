//
//  KurozoraKit+Legal.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches the latest Privacy Policy.
	///
	/// - Returns: A ``LegalResponse`` with the privacy policy.
	public func getPrivacyPolicy() async throws -> LegalResponse {
		let request = KKRequest<LegalResponse>(
			path: KKEndpoint.Legal.privacyPolicy.endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the latest Terms of Use.
	///
	/// - Returns: A ``LegalResponse`` with the terms of use.
	public func getTermsOfUse() async throws -> LegalResponse {
		let request = KKRequest<LegalResponse>(
			path: KKEndpoint.Legal.termsOfUse.endpointValue,
			method: .get,
			headers: self.headers
		)
		return try await self.client.send(request)
	}
}
