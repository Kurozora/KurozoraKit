//
//  RecapEntryAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

extension RecapEntry {
	/// The attributes of a recap entry.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The position of the entry in the recap.
		public let position: Int

		/// The number of parts of the entry.
		public let partsCount: Int

		/// The minutes spent on the entry.
		public let partsDuration: Double

		/// The role the entry's person held.
		public let role: String?
	}
}
