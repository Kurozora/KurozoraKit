//
//  SignInResult.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/04/2026.
//  MIT License
//

import Foundation

/// The outcome of a sign-in attempt.
public enum SignInResult: Sendable {
	/// The user has been signed in.
	case signedIn(SignInResponse)

	/// The account requires two-factor authentication to complete sign-in.
	case requiresTwoFactor(challengeToken: String)
}
