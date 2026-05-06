//
//  ParentalGuideRating.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// The set of available parental guide severity ratings.
///
/// ```
/// case none
/// case mild
/// case moderate
/// case severe
/// ```
public enum ParentalGuideRating: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// No content of this kind.
	case none = 0

	/// Mild content.
	case mild = 1

	/// Moderate content.
	case moderate = 2

	/// Severe content.
	case severe = 3

	// MARK: - Properties
	/// The string value of a parental guide rating.
	public var stringValue: String {
		switch self {
		case .none:
			return "None"
		case .mild:
			return "Mild"
		case .moderate:
			return "Moderate"
		case .severe:
			return "Severe"
		}
	}
}
