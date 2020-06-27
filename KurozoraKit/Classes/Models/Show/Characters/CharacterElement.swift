//
//  CharacterElement.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/06/2020.
//

import SwiftyJSON
import TRON

/**
	A mutable object that stores information about a single character, such as the character's name, blood type, and hight.
*/
public class CharacterElement: JSONDecodable {
	// MARK: - Properties
	let id: Int?
	let name: String?
	let about: String?
	let image: String?
	let debut: String?
	let status: String?
	let bloodType: String?
	let favoriteFood: String?
	let bust: Double?
	let waist: Double?
	let hip: Double?
	let height: String?
	let age: Int?
	let birthDay: Int?
	let birthMonth: Int?
	let astrologicalSign: AstrologicalSign?

	// MARK: - Initializers
	/// Initializes an empty instance of `CharacterElement`.
	internal init() {
		self.id = nil
		self.name = nil
		self.about = nil
		self.image = nil
		self.debut = nil
		self.status = nil
		self.bloodType = nil
		self.favoriteFood = nil
		self.bust = nil
		self.waist = nil
		self.hip = nil
		self.height = nil
		self.age = nil
		self.birthDay = nil
		self.birthMonth = nil
		self.astrologicalSign = nil
	}

	required public init(json: JSON) throws {
		self.id = json["id"].intValue
		self.name = json["name"].stringValue
		self.about = json["about"].stringValue
		self.image = json["image"].stringValue
		self.debut = json["debut"].stringValue
		self.status = json["status"].stringValue
		self.bloodType = json["blood_type"].stringValue
		self.favoriteFood = json["favorite_food"].stringValue
		self.bust = json["bust"].doubleValue
		self.waist = json["waist"].doubleValue
		self.hip = json["hip"].doubleValue
		self.height = json["height"].stringValue
		self.age = json["age"].intValue
		self.birthDay = json["birth_day"].intValue
		self.birthMonth = json["birth_month"].intValue
		self.astrologicalSign = AstrologicalSign(rawValue: json["astrological_sign"].intValue)
	}
}
