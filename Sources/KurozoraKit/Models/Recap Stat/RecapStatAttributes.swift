//
//  RecapStatAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/09/2026.
//  MIT License
//

import Foundation

extension RecapStat {
	/// The attributes of a recap stat.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The year of the stat.
		public let year: Int

		/// The month of the stat.
		public let month: Int

		/// The type of the stat.
		public let stat: RecapStatType

		/// The value of the stat.
		public let value: Int

		/// The day the stat occurred on.
		public let occurredAt: Date?
	}
}
