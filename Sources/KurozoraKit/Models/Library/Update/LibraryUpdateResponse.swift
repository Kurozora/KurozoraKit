//
//  LibraryUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/08/2020.
//  MIT License
//

import Foundation

/// A root object that stores information about a library's update.
public struct LibraryUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data envelope returned by add/update/remove endpoints.
	public let data: LibraryUpdateData
}

/// The data envelope returned by `/me/library` mutating endpoints.
public struct LibraryUpdateData: Codable, Sendable {
	// MARK: - Properties
	/// The aggregate library attributes resulting from the mutation.
	public let attributes: LibraryAttributes

	/// The relationship rows touched by the mutation, projected into the `LibrarySyncEntry` shape.
	public let relationships: LibraryUpdateRelationships
}

/// The relationships envelope of a library update response.
public struct LibraryUpdateRelationships: Codable, Sendable {
	// MARK: - Properties
	/// The library entries touched by the mutation.
	public let libraries: [LibrarySyncEntry]
}
