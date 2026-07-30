//
//  KotodamaSubjectIdentity.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores the identity of the catalog entry an answer was mined from.
public struct KotodamaSubjectIdentity: KurozoraItem, Codable, Hashable {
	// MARK: - Properties
	public let id: KurozoraItemID

	/// The type of the resource.
	public let type: String

	/// The relative link to where the resource is located.
	public let href: String

	/// The kind of the subject.
	public var kind: KotodamaSubjectKind? {
		// Show identities use the singular 'show' type.
		if self.type == "show" {
			return .shows
		}

		return KotodamaSubjectKind(rawValue: self.type)
	}
}
