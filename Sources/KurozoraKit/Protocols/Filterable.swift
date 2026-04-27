//
//  Filterable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

/// A type that can convert its properties into a dictionary suitable for API filter parameters.
public protocol Filterable: Sendable {
	/// Return a dictionary mapping API parameter names to their filter values.
	func toFilterArray() -> [String: Any?]
}
