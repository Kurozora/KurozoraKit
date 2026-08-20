//
//  NoteUpdate.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 21/08/2026.
//  MIT License
//

import Foundation

/// A root object that stores information about a note update response.
public struct NoteUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a note update request.
	public let data: NoteUpdate
}

/// A root object that stores the note as it stands after a write.
public struct NoteUpdate: Codable, Sendable {
	// MARK: - Properties
	/// The note's attributes.
	public let attributes: NoteUpdateAttributes
}

/// The attributes of a note after a write.
public struct NoteUpdateAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The note the user wrote, or `nil` when the note was cleared.
	public let body: String?

	/// The timestamp at which the note was written, in seconds since the Unix epoch.
	public let createdAt: Int?

	/// The timestamp at which the note was last edited, in seconds since the Unix epoch.
	public let updatedAt: Int?
}
