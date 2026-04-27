//
//  ResourceCollection.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A typed collection of resources returned by a paginated API response.
///
/// Use `ResourceCollection` as the generic response type for endpoints that
/// return arrays of resources. The collection carries optional pagination
/// metadata so callers can request subsequent pages.
public struct ResourceCollection<T: Codable & Sendable>: Codable, Sendable {
	// MARK: - Properties
	/// The decoded items in this page.
	public let data: [T]

	/// An opaque cursor for the next page, or `nil` if this is the last page.
	public let nextCursor: PageCursor?

	/// The total number of items across all pages, if provided by the server.
	public let total: Int?

	// MARK: - CodingKeys
	private enum CodingKeys: String, CodingKey {
		case data
		case next
		case total
	}

	// MARK: - Codable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.data = try container.decode([T].self, forKey: .data)
		self.total = try container.decodeIfPresent(Int.self, forKey: .total)

		if let nextURLString = try container.decodeIfPresent(String.self, forKey: .next) {
			self.nextCursor = PageCursor(urlString: nextURLString)
		} else {
			self.nextCursor = nil
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.data, forKey: .data)
		try container.encodeIfPresent(self.nextCursor?.urlString, forKey: .next)
		try container.encodeIfPresent(self.total, forKey: .total)
	}
}

// MARK: - KurozoraRequestable
extension ResourceCollection: KurozoraRequestable where T: KurozoraItem {
	public typealias Item = T
}
