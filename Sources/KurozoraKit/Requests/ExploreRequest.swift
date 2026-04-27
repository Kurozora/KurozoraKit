//
//  ExploreRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches the explore page content, optionally filtered by genre or theme.
public struct ExploreRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private var _genreID: KurozoraItemID?
	private var _themeID: KurozoraItemID?

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
		self._genreID = nil
		self._themeID = nil
	}

	// MARK: - Modifiers
	/// Filters the explore page by the given genre.
	public func genre(_ genreID: KurozoraItemID?) -> Self {
		var copy = self
		copy._genreID = genreID
		return copy
	}

	/// Filters the explore page by the given theme.
	public func theme(_ themeID: KurozoraItemID?) -> Self {
		var copy = self
		copy._themeID = themeID
		return copy
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<ExploreCategory> {
		var parameters: [String: Any] = [:]
		if let genreID = self._genreID {
			parameters["genre_id"] = genreID
		}
		if let themeID = self._themeID {
			parameters["theme_id"] = themeID
		}

		let request = KKRequest<ResourceCollection<ExploreCategory>>(
			path: KKEndpoint.Explore.index.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters.isEmpty ? nil : parameters
		)
		return try await self.context.client.send(request)
	}
}
