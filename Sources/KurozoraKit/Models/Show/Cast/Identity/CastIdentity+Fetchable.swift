//
//  CastIdentity+Fetchable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

extension CastIdentity: Fetchable {
	public typealias Response = ResourceCollection<Cast>

	public var detailEndpoint: String {
		switch self.type {
		case "show-cast":
			return KKEndpoint.Cast.showCast(self).endpointValue
		case "literature-cast":
			return KKEndpoint.Cast.literatureCast(self).endpointValue
		case "game-cast":
			return KKEndpoint.Cast.gameCast(self).endpointValue
		default:
			return KKEndpoint.Cast.showCast(self).endpointValue
		}
	}

	public var indexEndpoint: String {
		switch self.type {
		case "show-cast":
			return KKEndpoint.Cast.showCastIndex.endpointValue
		case "literature-cast":
			return KKEndpoint.Cast.literatureCastIndex.endpointValue
		case "game-cast":
			return KKEndpoint.Cast.gameCastIndex.endpointValue
		default:
			return KKEndpoint.Cast.showCastIndex.endpointValue
		}
	}
}
