//
//  StoreProductType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/05/2026.
//  MIT License
//

import Foundation

/// Store product types.
///
/// - Tag: StoreProductType
public enum StoreProductType: Int, CaseIterable, Codable, Sendable {
	// MARK: - Cases
	/// A consumable in-app purchase.
	case consumable = 0

	/// A non-consumable in-app purchase.
	case nonConsumable = 1

	/// A non-renewing subscription.
	case nonRenewingSubscription = 2

	/// An auto-renewable subscription.
	case autoRenewingSubscription = 3
}
