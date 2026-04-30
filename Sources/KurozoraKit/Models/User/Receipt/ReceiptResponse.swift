//
//  ReceiptResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/04/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a receipt verification response.
public struct ReceiptResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a receipt verification request.
	public let data: Receipt
}
