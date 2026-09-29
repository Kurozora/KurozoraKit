//
//  LanguageSupportType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2026.
//  MIT License
//

/// The set of available language support types.
///
/// - `audio`: the title is spoken in the language.
/// - `subtitles`: the title is subtitled in the language.
/// - `interface`: the title's interface is translated into the language.
/// - `text`: the title's text is published in the language.
///
/// - Tag: LanguageSupportType
public enum LanguageSupportType: Int, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// Indicates the title is spoken in the language.
	case audio = 1

	/// Indicates the title is subtitled in the language.
	case subtitles = 2

	/// Indicates the title's interface is translated into the language.
	case interface = 3

	/// Indicates the title's text is published in the language.
	case text = 4
}
