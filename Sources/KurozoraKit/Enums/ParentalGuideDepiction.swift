//
//  ParentalGuideDepiction.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// The set of available parental guide depiction levels.
///
/// ```
/// case implied
/// case shown
/// case graphic
/// ```
public enum ParentalGuideDepiction: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The content is implied but not shown.
	case implied = 1

	/// The content is shown on screen without graphic detail.
	case shown = 2

	/// The content is shown in graphic detail.
	case graphic = 3

	// MARK: - Properties
	/// The string value of a parental guide depiction.
	public var stringValue: String {
		switch self {
		case .implied:
			return "Implied"
		case .shown:
			return "Shown"
		case .graphic:
			return "Graphic"
		}
	}
}
