//
//  GenreIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension GenreIdentity: Fetchable {
	public typealias Response = ResourceCollection<Genre>

	public var detailEndpoint: String {
		KKEndpoint.Genres.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Genres.index.endpointValue
	}
}
