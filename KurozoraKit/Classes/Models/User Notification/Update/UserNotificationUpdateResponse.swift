//
//  UserNotificationUpdateResponse.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 06/08/2020.
//

import Foundation

/// A root object that stores information about a user notification update.
public struct UserNotificationUpdateResponse: Codable, Sendable {
	// MARK: - Properties
	/// The data included in the response for a user notification update object request.
	public let data: UserNotificationUpdate
}
