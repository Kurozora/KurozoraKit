//
//  KKServices.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 06/04/2020.
//  MIT License
//

import KeychainAccess

/// A services provider for ``KurozoraKit/KurozoraKit`` that manages Keychain access.
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

	// MARK: - Initializers
	/// Creates a services provider with the given Keychain instance.
	///
	/// - Parameter keychain: The `Keychain` instance to use for managing secrets.
	public init(keychain: Keychain = Keychain()) {
		self._keychainDefaults = keychain
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
