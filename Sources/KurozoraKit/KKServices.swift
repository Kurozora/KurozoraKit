//
//  KKServices.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 06/04/2020.
//  MIT License
//

import KeychainAccess

/// A services provider for ``KurozoraKit/KurozoraKit`` that manages Keychain access and the realtime client.
///
/// Provide a custom `Keychain` instance to control how secrets are stored.
///
/// - Tag: KKServices
public class KKServices {
	/// Provides access to the `Keychain` service used by ``KurozoraKit/KurozoraKit``.
	internal var _keychainDefaults: Keychain
	/// Provides access to the `Keychain` service used by ``KurozoraKit/KurozoraKit``.
	var keychainDefaults: Keychain {
		get {
			return _keychainDefaults
		}
	}

	/// Provides access to the Kurozora WebSocket for realtime functionality.
	internal let _webSocket: KKWebSocket?

	// MARK: - Initializers
	/// Creates a services provider.
	///
	/// - Parameters:
	///    - keychain: The `Keychain` instance to use for managing secrets.
	///    - webSocketAppKey: The public realtime app key. Pass `nil` to disable the realtime channel.
	public init(keychain: Keychain = Keychain(), webSocketAppKey: String? = nil) {
		self._keychainDefaults = keychain
		self._webSocket = webSocketAppKey.flatMap { key in
			key.isEmpty ? nil : KKWebSocket(appKey: key)
		}
	}

	// MARK: - Functions
	/// Sets the Keychain instance used for managing secrets.
	///
	/// - Parameter keychain: The `Keychain` instance to use.
	///
	/// - Returns: Reference to `self`.
	func keychainDefaults(_ keychain: Keychain) -> Self {
		self._keychainDefaults = keychain
		return self
	}
}

// MARK: - Binding
extension KKServices {
	/// Binds the realtime WebSocket to its owning ``KurozoraKit/KurozoraKit``.
	internal func _bind(to kurozoraKit: KurozoraKit) {
		guard let webSocket = self._webSocket else { return }
		let reference = KurozoraKitReference(kurozoraKit)

		Task {
			await webSocket._bind(to: reference)
		}
	}
}
