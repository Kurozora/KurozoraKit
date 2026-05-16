//
//  RequestContext.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A snapshot of the network client and resolved headers used to issue a single API request.
///
/// A `RequestContext` is created at request construction time and captures the current
/// authentication state, ensuring in-flight requests are unaffected by subsequent
/// credential changes. It also retains a weak reference to the originating
/// ``KurozoraKit`` instance so that authentication requests can update the ``KurozoraKit``'s
/// session state and the shared ``User/current`` value when they complete successfully.
internal struct RequestContext: @unchecked Sendable {
	// MARK: - Properties
	/// The network client used to perform the request.
	let client: KKNetworkClient

	/// The HTTP headers, including any resolved authorization, captured at construction time.
	let headers: [String: String]

	/// A weak reference to the originating ``KurozoraKit`` instance, used to apply session state updates.
	private weak var kurozoraKit: KurozoraKit?

	// MARK: - Initializers
	/// Creates a new request context by snapshotting the current state of the given ``KurozoraKit`` instance.
	///
	/// - Parameter kurozoraKit: The ``KurozoraKit`` instance from which to capture the network client and headers.
	init(from kurozoraKit: KurozoraKit) {
		self.client = kurozoraKit.client
		var resolved = kurozoraKit.headers
		if !kurozoraKit.authenticationKey.isEmpty {
			resolved["Authorization"] = "Bearer \(kurozoraKit.authenticationKey)"
		}
		self.headers = resolved
		self.kurozoraKit = kurozoraKit
	}

	// MARK: - Headers
	/// Returns the request headers with the current realtime socket identifier appended.
	///
	/// - Returns: The request headers with the current realtime socket identifier appended.
	internal func headersWithSocketID() async -> [String: String] {
		var resolved = self.headers

		if let webSocket = self.kurozoraKit?.services._webSocket {
			if let socketID = await webSocket.socketID, !socketID.isEmpty {
				resolved["X-Socket-Id"] = socketID
			}
		}

		return resolved
	}

	// MARK: - Authentication state
	/// Records a successful sign in.
	///
	/// - Parameters:
	///    - token: The authentication token returned by the server.
	///    - user: The signed-in user, if available.
	@MainActor
	func applySignIn(token: String, user: User?) {
		self.kurozoraKit?.authenticationKey = token
		User.current = user
		NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
	}

	/// Records a successful sign out.
	@MainActor
	func applySignOut() {
		self.kurozoraKit?.authenticationKey = ""
		User.current = nil
		NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
	}

	/// Records a refreshed profile.
	///
	/// - Parameter user: The current user returned by the server, if available.
	@MainActor
	func applyProfile(_ user: User?) {
		User.current = user
		NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
	}
}
