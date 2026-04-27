//
//  RandomImagesRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches a collection of random images.
public struct RandomImagesRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: MediaKind
	private let collection: MediaCollection
	private var _limit: Int

	// MARK: - Initializers
	internal init(context: RequestContext, kind: MediaKind, collection: MediaCollection) {
		self.context = context
		self.kind = kind
		self.collection = collection
		self._limit = 1
	}

	// MARK: - Modifiers
	/// Sets the maximum number of images to return.
	public func limit(_ limit: Int) -> Self {
		var copy = self
		copy._limit = limit
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<Media> {
		let parameters: [String: Any] = [
			"type": self.kind.rawValue,
			"collection": self.collection.rawValue,
			"limit": self._limit
		]

		let request = KKRequest<ResourceCollection<Media>>(
			path: KKEndpoint.Images.random.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
