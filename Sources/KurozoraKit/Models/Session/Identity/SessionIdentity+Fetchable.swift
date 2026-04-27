//
//  SessionIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension SessionIdentity: Fetchable {
	public typealias Response = ResourceCollection<Session>

	public var detailEndpoint: String {
		KKEndpoint.Me.Sessions.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Me.Sessions.index.endpointValue
	}
}
