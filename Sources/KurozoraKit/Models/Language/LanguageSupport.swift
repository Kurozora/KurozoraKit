//
//  LanguageSupport.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about the language a title leads with.
public struct LanguageSupport: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The language's name.
	public let name: String?

	/// The language's ISO 639-1 code.
	public let code: String?

	/// The language's ISO 639-3 code.
	public let iso6393: String?

	/// The ways the language is supported.
	public let types: [LanguageSupportType]

	/// The number of languages the title supports.
	public let count: Int

	// MARK: - Functions
	public static func == (lhs: LanguageSupport, rhs: LanguageSupport) -> Bool {
		return lhs.code == rhs.code && lhs.types == rhs.types && lhs.count == rhs.count
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.code)
		hasher.combine(self.types)
		hasher.combine(self.count)
	}
}
