//
//  ParentalGuideCategory.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// The set of available parental guide categories.
///
/// ```
/// case sexAndNudity
/// case violenceAndGore
/// case profanity
/// case alcoholDrugsAndSmoking
/// case frighteningAndIntenseScenes
/// ```
public enum ParentalGuideCategory: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Sex & Nudity.
	case sexAndNudity = 1

	/// Violence & Gore.
	case violenceAndGore = 2

	/// Profanity.
	case profanity = 3

	/// Alcohol, Drugs & Smoking.
	case alcoholDrugsAndSmoking = 4

	/// Frightening & Intense Scenes.
	case frighteningAndIntenseScenes = 5

	// MARK: - Properties
	/// The string value of a parental guide category.
	public var stringValue: String {
		switch self {
		case .sexAndNudity:
			return "Sex & Nudity"
		case .violenceAndGore:
			return "Violence & Gore"
		case .profanity:
			return "Profanity"
		case .alcoholDrugsAndSmoking:
			return "Alcohol, Drugs & Smoking"
		case .frighteningAndIntenseScenes:
			return "Frightening & Intense Scenes"
		}
	}

	/// Whether the category accepts a depiction value alongside the rating.
	public var supportsDepiction: Bool {
		switch self {
		case .sexAndNudity, .violenceAndGore, .frighteningAndIntenseScenes:
			return true
		case .profanity, .alcoholDrugsAndSmoking:
			return false
		}
	}

	/// Whether the category accepts a frequency value.
	public var supportsFrequency: Bool {
		return true
	}
}
