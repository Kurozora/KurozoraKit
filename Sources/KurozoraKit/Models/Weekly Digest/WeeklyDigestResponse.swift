//
//  WeeklyDigestResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 28/06/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response of a weekly digest request.
public struct WeeklyDigestResponse: Codable, Sendable {
	// MARK: - Properties
	/// The ordered sections included in the response.
	public let data: [WeeklyDigestSection]
}
