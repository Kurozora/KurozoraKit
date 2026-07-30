//
//  KotodamaWordAttributes.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

extension KotodamaWord {
	/// A root object that stores information about a single word, such as the word's length, and difficulty.
	public struct Attributes: Codable, Sendable {
		// MARK: - Properties
		/// The number of letters in the answer.
		public let length: Int

		/// The difficulty of the word.
		public let difficulty: KotodamaDifficulty?

		/// The hint describing the answer's subject.
		public let hint: String?

		/// The media object of the subject's image.
		public let poster: Media?

		/// The kind of the subject, revealed alongside the poster.
		public let subjectType: String?

		/// The answer.
		public let answer: String?
	}
}
