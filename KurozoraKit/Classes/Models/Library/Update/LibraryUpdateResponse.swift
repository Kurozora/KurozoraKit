//
//  LibraryUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/08/2020.
//

/// A root object that stores information about a library's update.
public struct LibraryUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a library update object request.
	public let data: LibraryUpdate
}
