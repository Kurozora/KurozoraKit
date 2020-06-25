//
//  ActorElement.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//

import SwiftyJSON
import TRON

/**
	A mutable object that stores information about a single actor, such as the actor's name, role, and image.
*/
public class ActorElement: JSONDecodable {
	// MARK: - Properties
	/// The name of the actor.
	public let actorName: String?

	/// The role of the actor.
	public let actorRole: String?

	/// The link to an image of the actor.
	public let actorImageString: String?

	/// The name of the character in the show.
	public let characterName: String?

	/// The role of the character in the show.
	public let characterRole: String?

	/// The link to an image of the character.
	public let characterImageString: String?

	// MARK: - Initializers
	required public init(json: JSON) throws {
		self.actorName = json["actor_name"].stringValue
		self.actorRole = json["actor_role"].stringValue
		self.actorImageString = json["actor_image"].stringValue

		self.characterName = json["character_name"].stringValue
		self.characterRole = json["character_role"].stringValue
		self.characterImageString = json["character_image"].stringValue
	}
}
