//
//  KurozoraKit+Search.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/05/2022.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Fetches a list of resources matching the search query.
	///
	/// - Parameters:
	///    - scope: The scope of the search.
	///    - types: The types of resources to include in the search.
	///    - query: The search query string.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 5 and the maximum value is 25.
	///    - filter: The filters to apply on the search.
	///
	/// - Returns: A ``SearchResponse`` with the search results.
	public func search(_ scope: KKSearchScope, of types: [KKSearchType], for query: String, next: String? = nil, limit: Int = 5, filter: KKSearchFilter?) async throws -> SearchResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [
			"limit": limit,
		]

		if next == nil {
			let typeValues: [String] = types.map { $0.rawValue }

			parameters["scope"] = scope.queryValue
			parameters["types"] = typeValues
			parameters["query"] = query

			if let filter = filter {
				var filters: [String: Any] = [:]

				switch filter {
				case .appTheme(let filter as Filterable),
						.character(let filter as Filterable),
						.episode(let filter as Filterable),
						.game(let filter as Filterable),
						.literature(let filter as Filterable),
						.person(let filter as Filterable),
						.show(let filter as Filterable),
						.song(let filter as Filterable),
						.studio(let filter as Filterable),
						.user(let filter as Filterable):
					filters = filter.toFilterArray().compactMapValues { $0 }
				}

				do {
					let filterData = try JSONSerialization.data(withJSONObject: filters, options: [])
					parameters["filter"] = filterData.base64EncodedString()
				} catch {
					print("❌ Encode error: Could not make base64 string from filter data", filters)
				}
			}
		}

		let request = KKRequest<SearchResponse>(
			path: next ?? KKEndpoint.Search.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches search suggestions matching the given query.
	///
	/// - Parameters:
	///    - scope: The scope of the search.
	///    - types: The types of resources to include in the suggestions.
	///    - query: The search query string.
	///
	/// - Returns: A ``SearchSuggestionsResponse`` with the search suggestions.
	public func getSearchSuggestions(_ scope: KKSearchScope, of types: [KKSearchType], for query: String) async throws -> SearchSuggestionsResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let typeValues: [String] = types.map { $0.rawValue }

		let parameters: [String: Any] = [
			"scope": scope.queryValue,
			"types": typeValues,
			"query": query
		]

		let request = KKRequest<SearchSuggestionsResponse>(
			path: KKEndpoint.Search.suggestions.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}
}
