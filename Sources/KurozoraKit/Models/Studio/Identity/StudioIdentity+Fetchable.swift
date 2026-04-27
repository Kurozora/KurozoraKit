//
//  StudioIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension StudioIdentity: Fetchable {
	public typealias Response = ResourceCollection<Studio>

	public var detailEndpoint: String {
		KKEndpoint.Studios.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Studios.index.endpointValue
	}
}
