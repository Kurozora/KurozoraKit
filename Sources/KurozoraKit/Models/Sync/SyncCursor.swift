//
//  SyncCursor.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// An opaque cursor for resuming a CloudKit-style delta sync from a known point.
public struct SyncCursor: Codable, Sendable, Equatable {
	// MARK: - Properties
	/// The opaque, microsecond-precision timestamp of the last row in the previous response.
	public let updatedAt: String

	/// The row identifier used to break ties when multiple rows share `updatedAt`.
	public let id: String

	/// The server wall-clock at which the previous response was emitted, or `nil` for an older cursor.
	public let syncedAt: Int?

	// MARK: - Initializer
	public init(updatedAt: String, id: String, syncedAt: Int? = nil) {
		self.updatedAt = updatedAt
		self.id = id
		self.syncedAt = syncedAt
	}
}
