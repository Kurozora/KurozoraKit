//
//  Episode.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/08/2020.
//

/**
	A root object that stores information about an episode resource.
*/
public struct Episode: IdentityResource {
	// MARK: - Properties
	public let id: Int

	public let type: String

	public let href: String

	/// The attributes belonging to the episode.
	public let attributes: Episode.Attributes
}
