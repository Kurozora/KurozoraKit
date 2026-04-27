//
//  ShowIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension ShowIdentity: Fetchable {
	public typealias Response = ResourceCollection<Show>

	public var detailEndpoint: String {
		KKEndpoint.Shows.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Shows.index.endpointValue
	}
}
