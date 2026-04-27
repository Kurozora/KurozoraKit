//
//  UserIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension UserIdentity: Fetchable {
	public typealias Response = ResourceCollection<User>

	public var detailEndpoint: String {
		KKEndpoint.Users.profile(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Users.index.endpointValue
	}
}
