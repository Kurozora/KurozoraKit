//
//  StoreTransactionAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/05/2026.
//  MIT License
//

import Foundation

extension StoreTransaction {
	/// Attributes of a StoreKit transaction.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The original StoreKit transaction identifier.
		public let transactionID: String

		/// The product type.
		public let productType: StoreProductType?

		/// The StoreKit product identifier.
		public let productID: String

		/// The price in the smallest unit of the currency, scaled by 1,000.
		public let priceMilliunits: Int?

		/// The ISO 4217 currency code of the transaction.
		public let currency: String?

		/// The purchase date.
		public let purchasedAt: Date?

		/// The expiration date for a subscription, or `nil` for one-time purchases.
		public let expiresAt: Date?

		/// The date Apple revoked the transaction, or `nil` if not revoked.
		public let revokedAt: Date?

		/// Whether the transaction can be refunded.
		public let isRefundable: Bool
	}
}
