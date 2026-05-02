//
//  StoreTransactionsResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/05/2026.
//  MIT License
//

import Foundation

/// The response payload of a store transactions request.
public struct StoreTransactionsResponse: Codable, Sendable {
	// MARK: - Properties
	/// The transactions ordered by purchase date.
	public let data: [StoreTransaction]
}
