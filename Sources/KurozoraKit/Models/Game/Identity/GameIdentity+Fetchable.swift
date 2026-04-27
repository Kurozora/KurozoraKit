//
//  GameIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension GameIdentity: Fetchable {
	public typealias Response = ResourceCollection<Game>

	public var detailEndpoint: String {
		KKEndpoint.Games.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Games.index.endpointValue
	}
}
