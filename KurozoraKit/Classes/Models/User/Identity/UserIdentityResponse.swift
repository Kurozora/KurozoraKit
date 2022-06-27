//
//  UserIdentityResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/05/2022.
//

/// A root object that stores information about a collection of user follow.
public struct UserFollow: Codable {
	// MARK: - Properties
	/// The data included in the repsonse for a user object request.
	public let data: [User]

	/// The realtive URL to the next page in the paginated response.
	public let next: String?
}
