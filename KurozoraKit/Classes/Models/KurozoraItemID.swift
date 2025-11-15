//
//  KurozoraItemID.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/11/2025.
//

import Foundation

/// An object that represents a unique identifier for a Kurozora item.
@frozen public struct KurozoraItemID: Equatable, Hashable, Sendable, RawRepresentable, ExpressibleByStringLiteral {
	public typealias ExtendedGraphemeClusterLiteralType = String
	public typealias RawValue = String
	public typealias StringLiteralType = String
	public typealias UnicodeScalarLiteralType = String

	public let rawValue: String

	/// Creates a Kurozora item identifier with a string.
	public init(_ rawValue: String) {
		self.init(rawValue: rawValue)
	}

	public init(rawValue: String) {
		self.rawValue = rawValue
	}

	public init(stringLiteral value: String) {
		self.init(value)
	}
}

// MARK: - Codable
extension KurozoraItemID: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		self.init(rawValue: rawValue)
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.rawValue)
	}
}

// MARK: - CustomStringConvertible
extension KurozoraItemID: CustomStringConvertible {
	public var description: String {
		return self.rawValue
	}
}
