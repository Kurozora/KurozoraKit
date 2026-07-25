//
//  Lyrics.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/06/2026.
//  MIT License
//

import Foundation

/// A root object that stores the synced lyrics of a song resource.
public struct Lyrics: Codable, Sendable {
	// MARK: - Properties
	/// The id of the lyrics resource.
	public let id: String

	/// The type of the resource.
	public let type: String

	/// The attributes belonging to the lyrics.
	public let attributes: Lyrics.Attributes
}

// MARK: - Attributes
public extension Lyrics {
	/// A root object that stores information about the lyrics, such as its timing mode, voices, and lines.
	struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The provenance of the lyrics.
		public let source: String

		/// The original language of the lyrics.
		public let language: String

		/// The synchronization granularity of the lyrics.
		public let timing: String

		/// The silence in milliseconds before the first line begins.
		public let leadingSilenceMs: Int?

		/// The global timing offset in milliseconds applied to every timestamp.
		public let lyricOffsetMs: Int?

		/// The total duration of the lyrics in milliseconds.
		public let durationMs: Int?

		/// The cast of voices referenced by the lines.
		public let agents: [Lyrics.Agent]

		/// The lines of the lyrics.
		public let lines: [Lyrics.Line]
	}
}

// MARK: - Agent
public extension Lyrics {
	/// A voice that performs one or more lines.
	struct Agent: Codable, Sendable {
		// MARK: - Properties
		/// The key referenced by a line's agent.
		public let key: String

		/// The kind of voice.
		public let type: String
	}
}

// MARK: - Line
public extension Lyrics {
	/// A single line of the lyrics.
	struct Line: Codable, Sendable {
		// MARK: - Properties
		/// The key that identifies the line.
		public let key: String

		/// The position of the line within the lyrics.
		public let position: Int

		/// The structural part of the song the line belongs to.
		public let songPart: String?

		/// The key of the voice that performs the line.
		public let agent: String?

		/// The start of the line in milliseconds.
		public let beginMs: Int?

		/// The end of the line in milliseconds.
		public let endMs: Int?

		/// The text of the line.
		public let text: String

		/// The words of the line, when word-timed.
		public let words: [Lyrics.Word]

		/// The translations of the line.
		public let translations: [Lyrics.Translation]

		/// The transliterations of the line.
		public let transliterations: [Lyrics.Transliteration]
	}
}

// MARK: - Word
public extension Lyrics {
	/// A single word or syllable of a line.
	struct Word: Codable, Sendable {
		// MARK: - Properties
		/// The start of the word in milliseconds.
		public let beginMs: Int

		/// The end of the word in milliseconds.
		public let endMs: Int

		/// The text of the word.
		public let text: String

		/// Whether the word is a background vocal.
		public let background: Bool

		/// Whether a space follows the word.
		public let trailingSpace: Bool
	}
}

// MARK: - Translation
public extension Lyrics {
	/// A line-level translation of a line.
	struct Translation: Codable, Sendable {
		// MARK: - Properties
		/// The language of the translation.
		public let language: String

		/// The translated text.
		public let text: String
	}
}

// MARK: - Transliteration
public extension Lyrics {
	/// A transliteration of a line, optionally word-timed.
	struct Transliteration: Codable, Sendable {
		// MARK: - Properties
		/// The language of the transliteration.
		public let language: String

		/// The transliterated text.
		public let text: String

		/// The words of the transliteration, when word-timed.
		public let words: [Lyrics.Word]
	}
}
