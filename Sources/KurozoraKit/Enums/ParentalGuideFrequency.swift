//
//  ParentalGuideFrequency.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// The set of available parental guide frequency levels.
///
/// ```
/// case brief
/// case occasional
/// case frequent
/// ```
public enum ParentalGuideFrequency: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// A brief moment of this content.
	case brief = 1

	/// Occasional moments of this content.
	case occasional = 2

	/// Frequent moments of this content.
	case frequent = 3

	// MARK: - Properties
	/// The string value of a parental guide frequency.
	public var stringValue: String {
		switch self {
		case .brief:
			return "Brief"
		case .occasional:
			return "Occasional"
		case .frequent:
			return "Frequent"
		}
	}
}
