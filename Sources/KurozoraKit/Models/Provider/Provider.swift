//
//  Provider.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

/// A service where titles are watched.
public struct Provider: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the provider.
	public let attributes: Provider.Attributes

	// MARK: - Functions
	public static func == (lhs: Provider, rhs: Provider) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}
