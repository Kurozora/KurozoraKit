//
//  ReviewRecommendation.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2026.
//  MIT License
//

import Foundation

/// The set of available review recommendations.
///
/// ```
/// case notRecommended
/// case mixedFeelings
/// case recommended
/// ```
public enum ReviewRecommendation: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The reviewer does not recommend the item.
	case notRecommended = 0

	/// The reviewer has mixed feelings about the item.
	case mixedFeelings = 1

	/// The reviewer recommends the item.
	case recommended = 2

	// MARK: - Properties
	/// The recommendations in the order they are offered to the reviewer.
	public static let offeredOrder: [ReviewRecommendation] = [.recommended, .mixedFeelings, .notRecommended]

	/// The string value of a review recommendation.
	public var stringValue: String {
		switch self {
		case .notRecommended:
			return "Not Recommended"
		case .mixedFeelings:
			return "Mixed Feelings"
		case .recommended:
			return "Recommended"
		}
	}
}
