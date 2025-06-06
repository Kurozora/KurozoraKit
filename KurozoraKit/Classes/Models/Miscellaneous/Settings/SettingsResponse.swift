//
//  SettingsResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/12/2022.
//

/// A root object that stores information about a collection of settings.
public struct SettingsResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a settings object request.
	public let data: Settings
}
