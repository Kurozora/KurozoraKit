//
//  CharacterIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension CharacterIdentity: Fetchable {
	public typealias Response = ResourceCollection<Character>

	public var detailEndpoint: String {
		KKEndpoint.Characters.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Characters.index.endpointValue
	}
}
