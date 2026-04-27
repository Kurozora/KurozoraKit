//
//  LiteratureIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension LiteratureIdentity: Fetchable {
	public typealias Response = ResourceCollection<Literature>

	public var detailEndpoint: String {
		KKEndpoint.Literatures.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Literatures.index.endpointValue
	}
}
