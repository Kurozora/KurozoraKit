//
//  OverlayIdentityList.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

/// A list of identity references for a single relationship key on an overlay resource.
public struct OverlayIdentityList<I: Codable & Sendable>: Codable, Sendable {
	// MARK: - Properties
	/// The identity references populated for the relationship key.
	public let data: [I]
}
