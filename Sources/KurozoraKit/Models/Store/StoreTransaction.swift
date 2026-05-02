//
//  StoreTransaction.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/05/2026.
//  MIT License
//

import Foundation

/// A StoreKit transaction recorded by the backend.
public struct StoreTransaction: Codable, Sendable, Hashable {
	// MARK: - Properties
	/// The transaction identifier.
	public let id: String

	/// The type of the resource.
	public let type: String

	/// The transaction's attributes.
	public let attributes: StoreTransaction.Attributes

	// MARK: - Functions
	public static func == (lhs: StoreTransaction, rhs: StoreTransaction) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
