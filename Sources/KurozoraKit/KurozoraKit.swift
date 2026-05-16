//
//  KurozoraKit.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 11/07/2018.
//  MIT License
//

import Foundation

/// The main entry point for communicating with the [Kurozora](https://kurozora.app) API.
///
/// Configure a ``KurozoraKit`` instance with a ``KurozoraAPI`` endpoint and optional
/// ``KKServices`` for Keychain integration, then call its methods to fetch and
/// submit data.
///
/// - Tag: KurozoraKit
public class KurozoraKit {
	// MARK: - Properties
	/// The User-Agent string derived from the main app bundle, even when running in an extension.
	///
	/// Extensions (widgets, Watch apps) have their own bundle IDs and executable names. The API
	/// validates the User-Agent against the registered app client, so the User-Agent must always
	/// reflect the main app's identity. This property resolves the containing `.app` bundle by
	/// navigating up from `.appex` paths and reads its info dictionary.
	private static let mainAppUserAgent: String = {
		let mainAppBundle: Bundle = {
			let mainBundle = Bundle.main
			let bundlePath = mainBundle.bundlePath

			// Extensions live inside App.app/PlugIns/Extension.appex (or deeper for Watch)
			// Navigate up to find the .app bundle
			if !bundlePath.hasSuffix(".app") {
				var url = mainBundle.bundleURL
				while url.pathExtension != "app" && url.path != "/" {
					url = url.deletingLastPathComponent()
				}
				if url.pathExtension == "app", let appBundle = Bundle(url: url) {
					return appBundle
				}
			}
			return mainBundle
		}()

		let info = mainAppBundle.infoDictionary
		let executable = (info?["CFBundleExecutable"] as? String) ??
			(ProcessInfo.processInfo.arguments.first?.split(separator: "/").last.map(String.init)) ??
			"Unknown"

		// On watchOS the app is a standalone .app bundle so the navigation above
		// won't find the companion. Use WKCompanionAppBundleIdentifier instead.
		let bundle: String = {
			#if os(watchOS)
			if let companionID = info?["WKCompanionAppBundleIdentifier"] as? String {
				return companionID
			}
			#endif
			return info?["CFBundleIdentifier"] as? String ?? "Unknown"
		}()
		let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
		let appBuild = info?["CFBundleVersion"] as? String ?? "Unknown"

		let osNameVersion: String = {
			let version = ProcessInfo.processInfo.operatingSystemVersion
			let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
			#if os(iOS)
			#if targetEnvironment(macCatalyst)
			return "macOS(Catalyst) \(versionString)"
			#else
			return "iOS \(versionString)"
			#endif
			#elseif os(watchOS)
			return "watchOS \(versionString)"
			#elseif os(tvOS)
			return "tvOS \(versionString)"
			#elseif os(macOS)
			return "macOS \(versionString)"
			#elseif os(visionOS)
			return "visionOS \(versionString)"
			#else
			return "Unknown \(versionString)"
			#endif
		}()

		let kurozoraKitVersion = "2.0.0"
		return "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion)) KurozoraKit/\(kurozoraKitVersion)"
	}()

	/// Storage of the app's api key.
	internal var _apiKey: String = ""
	/// The current app's api key.
	public var apiKey: String {
		get {
			return self._apiKey
		}
		set {
			self._apiKey = newValue
		}
	}

	/// Storage of the current user's authentication key.
	internal var _authenticationKey: String = ""
	/// The current user's authentication key.
	public var authenticationKey: String {
		get {
			return self._authenticationKey
		}
		set {
			self._authenticationKey = newValue
		}
	}

	/// Storage of the current API endpoint.
	internal var _apiEndpoint: KurozoraAPI = .v1
	/// The current API Endpoint.
	public var apiEndpoint: KurozoraAPI {
		get {
			return self._apiEndpoint
		}
		set {
			self._apiEndpoint = newValue
		}
	}

	/// Most common HTTP headers for the Kurozora API.
	///
	/// Current headers are:
	/// ```swift
	/// "Content-Type": "application/x-www-form-urlencoded",
	/// "Accept": "application/json"
	/// ```
	internal let headers: [String: String]

	/// The network client used to perform API requests.
	internal var client: KKNetworkClient

	/// The ``KKServices`` object used to perform API requests.
	public var services: KKServices

	// MARK: - Initializers
	/// Initializes `KurozoraKit` with the given API endpoint, user authentication key and services.
	///
	/// - Parameters:
	///    - apiEndpoint: The ``KurozoraAPI`` endpoint to be used.
	///    - apiKey: The application's API key.
	///    - authenticationKey: The current signed in user's authentication key.
	///    - services: The desired ``KKServices`` to be used.
	public init(apiEndpoint: KurozoraAPI? = nil, apiKey: String = "", authenticationKey: String = "", services: KKServices = KKServices()) {
		let endpoint = apiEndpoint ?? .v1
		self._apiKey = apiKey
		self._authenticationKey = authenticationKey
		self._apiEndpoint = endpoint
		self.headers = [
			"Content-Type": "application/x-www-form-urlencoded",
			"Accept": "application/json",
			"X-API-Key": apiKey,
			"User-Agent": Self.mainAppUserAgent
		]
		self.client = KKNetworkClient(baseURL: endpoint.baseURL, options: endpoint.options)
		self.services = services
		services._bind(to: self)
	}

	// MARK: - Functions
	/// Sets the API endpoint for the Kurozora API.
	///
	/// - Parameter apiEndpoint: The desired ``KurozoraAPI`` endpoint to be used.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func apiEndpoint(_ apiEndpoint: KurozoraAPI) -> Self {
		self.apiEndpoint = apiEndpoint
		self.client = KKNetworkClient(baseURL: apiEndpoint.baseURL, options: apiEndpoint.options)
		return self
	}

	/// Sets the API key used to authenticate requests.
	///
	/// - Parameter apiKey: The application's API key.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func apiKey(_ apiKey: String) -> Self {
		self.apiKey = apiKey
		return self
	}

	/// Sets the authentication key for the current user session.
	///
	/// - Parameter authenticationKey: The user's authentication token.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func authenticationKey(_ authenticationKey: String) -> Self {
		self.authenticationKey = authenticationKey
		return self
	}

	/// Sets the services provider used for Keychain access and other platform integrations.
	///
	/// - Parameter services: The ``KKServices`` instance to use.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func services(_ services: KKServices) -> Self {
		self.services = services
		services._bind(to: self)
		return self
	}

	/// A stream of typed user notification events received via the realtime channel.
	///
	/// Returns an immediately-finished stream when no `webSocketAppKey` was configured on ``services``.
	///
	/// - Returns: An asynchronous sequence of ``UserNotification/Event`` values.
	public func userNotificationEvents() -> AsyncStream<UserNotification.Event> {
		guard let webSocket = self.services._webSocket else {
			return AsyncStream { $0.finish() }
		}

		return AsyncStream { continuation in
			let task = Task {
				for await event in await webSocket.userNotificationEvents() {
					continuation.yield(event)
				}
				continuation.finish()
			}
			continuation.onTermination = { _ in task.cancel() }
		}
	}
}
