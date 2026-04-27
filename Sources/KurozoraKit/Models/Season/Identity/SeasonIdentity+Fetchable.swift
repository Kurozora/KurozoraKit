//
//  SeasonIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension SeasonIdentity: Fetchable {
	public typealias Response = ResourceCollection<Season>

	public var detailEndpoint: String {
		KKEndpoint.Shows.Seasons.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Shows.Seasons.index.endpointValue
	}
}
