//
//  KotodamaShareGridAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaShareGrid {
	/// A root object that stores information about a single share grid, such as the grid's text.
	public struct Attributes: Codable, Hashable, Sendable {
		// MARK: - Properties
		/// The shareable text of the grid.
		public let text: String
	}
}
