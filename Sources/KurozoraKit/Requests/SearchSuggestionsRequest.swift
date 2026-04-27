//
//  SearchSuggestionsRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation

/// A request that fetches search suggestions matching the given query.
public struct SearchSuggestionsRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let scope: SearchScope
	private let types: [SearchType]
	private let query: String

	// MARK: - Initializers
	internal init(context: RequestContext, scope: SearchScope, types: [SearchType], query: String) {
		self.context = context
		self.scope = scope
		self.types = types
		self.query = query
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> SearchSuggestionsResponse {
		let parameters: [String: Any] = [
			"scope": self.scope.queryValue,
			"types": self.types.map { $0.rawValue },
			"query": self.query
		]

		let request = KKRequest<SearchSuggestionsResponse>(
			path: KKEndpoint.Search.suggestions.endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
