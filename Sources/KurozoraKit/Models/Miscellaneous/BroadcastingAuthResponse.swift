//
//  BroadcastingAuthResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 15/05/2026.
//  MIT License
//

import Foundation

/// A signed authorization for a private realtime channel subscription.
public struct BroadcastingAuthResponse: Codable, Sendable {
	// MARK: - Properties
	/// The body of the response.
	public let data: BroadcastingAuth

	// MARK: - Nested types
	/// The signed authorization payload.
	public struct BroadcastingAuth: Codable, Sendable {
		/// The auth signature.
		public let auth: String

		/// The resolved channel name the subscription will be made against.
		public let channelName: String
	}
}
