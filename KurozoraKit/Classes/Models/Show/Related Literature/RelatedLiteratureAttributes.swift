//
//  RelatedLiteratureAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/01/2023.
//

import Foundation

extension RelatedLiterature {
	/// A root object that stores information about a single related literature, such as the relation between the literature.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The relation between the literature.
		public let relation: MediaRelation
	}
}
