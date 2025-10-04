//
//  BlockUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/04/2025.
//

import Foundation

/// A root object that stores information about a user's block update.
public struct BlockUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a user block update object request.
	public let data: BlockUpdate
}
