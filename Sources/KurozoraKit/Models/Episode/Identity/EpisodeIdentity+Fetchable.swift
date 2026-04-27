//
//  EpisodeIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension EpisodeIdentity: Fetchable {
	public typealias Response = ResourceCollection<Episode>

	public var detailEndpoint: String {
		KKEndpoint.Episodes.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Episodes.index.endpointValue
	}
}
