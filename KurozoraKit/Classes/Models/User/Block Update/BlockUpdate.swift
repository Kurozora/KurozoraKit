//
//  BlockUpdate.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/04/2025.
//

import Foundation

/// A root object that stores information about a user block update resource.
public struct BlockUpdate: Codable, Sendable {
	// MARK: - Properties
	/// Whether the user is blocked or not.
	fileprivate var isBlocked: Bool?

	/// The block status of the user.
	fileprivate var _blockStatus: BlockStatus?
}

// MARK: - Helpers
extension BlockUpdate {
	// MARK: - Properties
	/// The block status of the user.
	public var blockStatus: BlockStatus {
		get {
			return self._blockStatus ?? BlockStatus(self.isBlocked)
		}
		set {
			self._blockStatus = newValue
		}
	}
}
