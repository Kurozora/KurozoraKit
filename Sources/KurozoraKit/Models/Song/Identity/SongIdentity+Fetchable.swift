//
//  SongIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension SongIdentity: Fetchable {
	public typealias Response = ResourceCollection<Song>

	public var detailEndpoint: String {
		KKEndpoint.Songs.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Songs.index.endpointValue
	}
}
