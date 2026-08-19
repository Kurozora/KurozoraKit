//
//  ReportReason.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/08/2026.
//  MIT License
//

/// The set of available report reasons.
public enum ReportReason: String, Codable, CaseIterable, Sendable {
	// MARK: - Cases
	/// The content is spam or advertising.
	case spam

	/// The review is a joke, a meme, or off topic.
	case notAReview = "not_a_review"

	/// The content contains an unmarked spoiler.
	case spoiler

	/// The content is hateful, harassing, or threatening.
	case abuse

	/// The content is inappropriate.
	case inappropriate

	/// The content concerns suicide or self-harm.
	case selfHarm = "self_harm"

	/// The content links to an unauthorized source.
	case piracy

	/// Some other reason. Requires accompanying `details`.
	case other

	// MARK: - Properties
	/// The reasons offered when reporting a review.
	public static let offeredForReview: [Self] = [
		.notAReview, .spam, .spoiler, .piracy, .abuse, .inappropriate, .other
	]

	/// The reasons offered when reporting a feed message.
	public static let offeredForFeedMessage: [Self] = [
		.spam, .spoiler, .piracy, .abuse, .inappropriate, .selfHarm, .other
	]
}
