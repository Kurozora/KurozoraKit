//
//  MuseumIndexRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 01/08/2026.
//  MIT License
//

import Foundation

/// A request that fetches the museum years for a given library kind.
public struct MuseumIndexRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let libraryKind: LibraryKind

	// MARK: - Initializers
	internal init(context: RequestContext, libraryKind: LibraryKind) {
		self.context = context
		self.libraryKind = libraryKind
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<MuseumYear> {
		let request = KKRequest<ResourceCollection<MuseumYear>>(
			path: KKEndpoint.Museum.index(self.libraryKind).endpointValue,
			method: .get,
			headers: self.context.headers
		)
		return try await self.context.client.send(request)
	}
}
