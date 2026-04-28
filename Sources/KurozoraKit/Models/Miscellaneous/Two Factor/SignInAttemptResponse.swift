//
//  SignInAttemptResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/04/2026.
//  MIT License
//

import Foundation

/// An internal decoding container for the response to a sign-in attempt.
internal struct SignInAttemptResponse: Decodable, Sendable {
	// MARK: - Properties
	/// The authentication token returned for an authenticated session, if any.
	let authenticationToken: String?

	/// The signed-in user returned for an authenticated session, if any.
	let data: [User]?

	/// A Boolean value indicating whether a two-factor challenge is required.
	let twoFactor: Bool?

	/// The short-lived challenge token to redeem when two-factor authentication is required.
	let challengeToken: String?

	// MARK: - CodingKeys
	/// The coding keys used to decode the response from its serialized representation.
	enum CodingKeys: String, CodingKey {
		case authenticationToken
		case data
		case twoFactor = "two_factor"
		case challengeToken = "challenge_token"
	}
}
