//
//  KotodamaGuess.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 30/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a single guess, such as the guess' position, and feedback.
public struct KotodamaGuess: Codable, Hashable, Sendable {
	// MARK: - Properties
	/// The one-based position of the guess within the game.
	public let position: Int

	/// The guessed word.
	public let guess: String

	/// The per-letter feedback for the guess.
	public let feedback: String

	/// The date the guess was submitted.
	public let createdAt: Date?

	/// The feedback of the guess, one value per letter.
	public var tiles: [KotodamaTileFeedback] {
		return self.feedback.compactMap { KotodamaTileFeedback(rawValue: String($0)) }
	}
}
