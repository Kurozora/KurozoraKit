//
//  Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import Foundation

/// A type that provides the API endpoint paths needed to fetch its details.
///
/// Conform identity types to `Fetchable` to enable typed detail and batch
/// detail requests through ``DetailRequest`` and ``BatchDetailRequest``.
public protocol Fetchable: KurozoraItem, Codable {
	/// The response type returned by a detail fetch for this resource.
	associatedtype Response: KurozoraRequestable

	/// The endpoint path for fetching the details of this resource.
	var detailEndpoint: String { get }

	/// The index endpoint path for fetching multiple resources by ID.
	var indexEndpoint: String { get }
}
