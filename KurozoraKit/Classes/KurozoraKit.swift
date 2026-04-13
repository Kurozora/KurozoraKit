//
//  KurozoraKit.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 11/07/2018.
//

import Alamofire
import TRON
import Foundation

/// `KurozoraKit` is a root object that serves as a provider for single API endpoint. It is used to send and get data from [Kurozora](https://kurozora.app).
///
/// For more flexibility when using `KurozoraKit` you can provide your own endpoint using ``KurozoraAPI``.
/// You can also provide your own ``KKServices``. This enables you to provide extra functionality such as storing sensetive information in `Keychain`.
/// For further control over the information saved in `Keychain`, you can provide your own `Keychain` object with your specified properties.
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

		let kurozoraKitVersion = "1.0.0"
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
	internal let headers: HTTPHeaders

	/// The TRON singleton used to perform API requests.
	internal var tron: TRON!

	/// The ``KKServices`` object used to perform API requests.
	public var services: KKServices!

	// MARK: - Initializers
	/// Initializes `KurozoraKit` with the given API endpoint, user authentication key and services.
	///
	/// - Parameters:
	///    - apiEndpoint: The ``KurozoraAPI`` endpoint to be used.
	///    - authenticationKey: The current signed in user's authentication key.
	///    - services: The desired ``KKServices`` to be used.
	public init(apiEndpoint: KurozoraAPI? = nil, apiKey: String = "", authenticationKey: String = "", services: KKServices = KKServices()) {
		self.headers = [
			.contentType("application/x-www-form-urlencoded"),
			.accept("application/json"),
			.init(name: "X-API-Key", value: apiKey),
			.userAgent(Self.mainAppUserAgent)
		]

		self.apiEndpoint(apiEndpoint ?? .v1)
			.apiKey(apiKey)
			.authenticationKey(authenticationKey)
			.services(services)
	}

	// MARK: - Functions
	/// Sets the API endpoint for the Kurozora API.
	///
	/// - Parameter apiEndpoint: The desired ``KurozoraAPI`` endpoint to be used.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func apiEndpoint(_ apiEndpoint: KurozoraAPI) -> Self {
		let plugins: [Plugin] = switch apiEndpoint {
		case .v1:
			[]
		case .custom(_, let plugin):
			plugin ?? [NetworkLoggerPlugin()]
		}

		self.apiEndpoint = apiEndpoint
		self.tron = TRON(baseURL: apiEndpoint.baseURL, plugins: plugins)
		self.tron.codable.modelDecoder.dateDecodingStrategy = .secondsSince1970

		return self
	}

	/// Sets the `apiKey` property with the given auth key.
	///
	/// - Parameter apiKey: The current user's authentication key.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func apiKey(_ apiKey: String) -> Self {
		self.apiKey = apiKey
		return self
	}


	/// Sets the `authenticationKey` property with the given auth key.
	///
	/// - Parameter authenticationKey: The current user's authentication key.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func authenticationKey(_ authenticationKey: String) -> Self {
		self.authenticationKey = authenticationKey
		return self
	}

	/// Sets the `services` property with the given ``KKServices`` object.
	///
	/// - Parameter services: The ``KKServices`` object to be used when performin API requests.
	///
	/// - Returns: Reference to `self`.
	@discardableResult
	public func services(_ services: KKServices) -> Self {
		self.services = services
		return self
	}
}
