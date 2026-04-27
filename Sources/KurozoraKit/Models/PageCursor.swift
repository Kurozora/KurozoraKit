//
//  PageCursor.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// An opaque cursor representing the position of the next page in a
/// paginated response.
///
/// Retrieve a cursor from ``ResourceCollection/nextCursor`` and pass it
/// into the same request's `.cursor(_:)` modifier to load the next page.
public struct PageCursor: Hashable, Sendable {
	/// The absolute URL string of the next page, as returned by the server.
	internal let urlString: String
}
