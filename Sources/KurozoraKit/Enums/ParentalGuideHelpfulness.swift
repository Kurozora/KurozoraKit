//
//  ParentalGuideHelpfulness.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 06/05/2026.
//  MIT License
//

import Foundation

/// The set of available helpfulness states for a parental guide entry.
///
/// ```
/// case unhelpful = -1
/// case disabled = 0
/// case helpful = 1
/// ```
public enum ParentalGuideHelpfulness: Int, Codable, Sendable {
	// MARK: - Cases
	/// The entry is marked unhelpful by the authenticated user.
	case unhelpful = -1

	/// The entry can't be marked helpful or unhelpful.
	case disabled = 0

	/// The entry is marked helpful by the authenticated user.
	case helpful = 1

	// MARK: - Initializers
	/// Initializes an instance of `ParentalGuideHelpfulness` with the given bool value.
	///
	/// If `nil` is given, then an instance of `.disabled` is initialized.
	///
	/// - Parameter bool: The boolean value used to initialize an instance of `ParentalGuideHelpfulness`.
	public init(_ bool: Bool?) {
		if let bool = bool {
			self = bool ? .helpful : .unhelpful
		} else {
			self = .disabled
		}
	}
}
