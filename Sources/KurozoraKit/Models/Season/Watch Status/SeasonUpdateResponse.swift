//
//  SeasonUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/09/2023.
//  MIT License
//

import Foundation

/// A root object that stores information about a season's update.
public struct SeasonUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a season update object request.
	public let data: SeasonUpdate
}
