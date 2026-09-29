//
//  SupportedLanguage.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a language a title is available in.
public struct SupportedLanguage: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The language's name.
	public let name: String

	/// The language's ISO 639-1 code.
	public let code: String

	/// The language's ISO 639-3 code.
	public let iso6393: String

	/// The way the language is supported.
	public let type: LanguageSupportType

	/// Whether the title was originally made in the language.
	public let isOriginal: Bool

	// MARK: - Functions
	public static func == (lhs: SupportedLanguage, rhs: SupportedLanguage) -> Bool {
		return lhs.code == rhs.code && lhs.type == rhs.type
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.code)
		hasher.combine(self.type)
	}
}
