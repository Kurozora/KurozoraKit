//
//  ThemeIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension ThemeIdentity: Fetchable {
	public typealias Response = ResourceCollection<Theme>

	public var detailEndpoint: String {
		KKEndpoint.Themes.details(self).endpointValue
	}

	public var indexEndpoint: String {
		KKEndpoint.Themes.index.endpointValue
	}
}
