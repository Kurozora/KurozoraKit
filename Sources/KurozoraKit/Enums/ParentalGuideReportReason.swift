//
//  ParentalGuideReportReason.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 08/05/2026.
//  MIT License
//

import Foundation

/// The available reasons for reporting a parental guide entry.
public enum ParentalGuideReportReason: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The entry is inaccurate.
	case inaccurate

	/// The entry contains an unmarked spoiler.
	case spoiler

	/// The entry is spam.
	case spam

	/// The entry is inappropriate.
	case inappropriate

	/// Some other reason. Requires accompanying `details`.
	case other
}
