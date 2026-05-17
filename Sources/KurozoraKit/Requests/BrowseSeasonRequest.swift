//
//  BrowseSeasonRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 17/05/2026.
//  MIT License
//

import Foundation

/// A request that fetches the seasonal browse listing for a given kind, year and season.
public struct BrowseSeasonRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: BrowseSeasonType
	private let year: Int
	private let season: SeasonOfYear
	private let mediaTypeIDs: [Int]

	// MARK: - Initializers
	internal init(context: RequestContext, kind: BrowseSeasonType, year: Int, season: SeasonOfYear, mediaTypeIDs: [Int] = []) {
		self.context = context
		self.kind = kind
		self.year = year
		self.season = season
		self.mediaTypeIDs = mediaTypeIDs
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> ResourceCollection<BrowseSeason> {
		var parameters: [String: Any] = [
			"year": self.year,
			"season": self.season.rawValue
		]

		for (index, id) in self.mediaTypeIDs.enumerated() {
			parameters["mediaTypes[\(index)]"] = id
		}

		let request = KKRequest<ResourceCollection<BrowseSeason>>(
			path: KKEndpoint.BrowseSeason.index(kind: self.kind).endpointValue,
			method: .get,
			headers: self.context.headers,
			query: parameters
		)
		return try await self.context.client.send(request)
	}
}
