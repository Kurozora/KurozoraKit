//
//  PersonIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension PersonIdentity: Fetchable {
	public typealias Response = ResourceCollection<Person>

	public var detailEndpoint: String {
		KKEndpoint.People.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.People.index.endpointValue
	}
}
