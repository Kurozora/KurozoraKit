//
//  UpdateMeSettingsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/08/2026.
//  MIT License
//

import Foundation

/// A request that updates the authenticated user's settings.
///
/// ```swift
/// let settings = try await kurozoraKit
///     .updateSettings()
///     .ratingStyle(.detailed)
///     .response()
/// ```
public struct UpdateMeSettingsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _ratingStyle: RatingStyle?
	private var _scrobbleThreshold: Int?
	private var _discordRichPresenceEnabled: Bool?
	private var _discordPresenceImage: Int?
	private var _discordActivityName: Int?

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
		self._ratingStyle = nil
		self._scrobbleThreshold = nil
		self._discordRichPresenceEnabled = nil
		self._discordPresenceImage = nil
		self._discordActivityName = nil
	}

	// MARK: - Modifiers
	/// Sets the style used to rate and review media.
	public func ratingStyle(_ ratingStyle: RatingStyle) -> Self {
		var copy = self
		copy._ratingStyle = ratingStyle
		return copy
	}

	/// Sets the percentage of a media that must be played before it is scrobbled.
	public func scrobbleThreshold(_ threshold: Int) -> Self {
		var copy = self
		copy._scrobbleThreshold = threshold
		return copy
	}

	/// Sets whether the user's Discord rich presence is enabled.
	public func discordRichPresenceEnabled(_ isEnabled: Bool) -> Self {
		var copy = self
		copy._discordRichPresenceEnabled = isEnabled
		return copy
	}

	/// Sets the image shown in the user's Discord rich presence.
	public func discordPresenceImage(_ image: Int) -> Self {
		var copy = self
		copy._discordPresenceImage = image
		return copy
	}

	/// Sets the activity name shown in the user's Discord rich presence.
	public func discordActivityName(_ activityName: Int) -> Self {
		var copy = self
		copy._discordActivityName = activityName
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> MeSettingsResponse {
		var body: [String: Any] = [:]

		if let ratingStyle = self._ratingStyle {
			body["ratingStyle"] = ratingStyle.rawValue
		}
		if let scrobbleThreshold = self._scrobbleThreshold {
			body["scrobbleThreshold"] = scrobbleThreshold
		}
		if let discordRichPresenceEnabled = self._discordRichPresenceEnabled {
			body["discordRichPresenceEnabled"] = discordRichPresenceEnabled
		}
		if let discordPresenceImage = self._discordPresenceImage {
			body["discordPresenceImage"] = discordPresenceImage
		}
		if let discordActivityName = self._discordActivityName {
			body["discordActivityName"] = discordActivityName
		}

		let request = KKRequest<MeSettingsResponse>(
			path: KKEndpoint.Me.settingsUpdate.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)
		return try await self.context.client.send(request)
	}
}
