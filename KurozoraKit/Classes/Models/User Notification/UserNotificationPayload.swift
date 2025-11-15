//
//  UserNotificationData.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//

import Foundation

extension UserNotification {
	/// A root object that stores information about user notification payload.
	public struct Payload: Codable, Sendable {
		// MARK: - Properties
		// Session
		/// The ip address of a session.
		public let ip: String?

		/// The id of a session.
		public let sessionID: String?

		// Follower
		/// The id of a follower.
		public let userID: KurozoraItemID?

		/// The username of a follower.
		public let username: String?

		/// The profile image of the follower.
		public let profileImageURL: String?

		// Feed Message
		/// The id of a feed message.
		public let feedMessageID: KurozoraItemID?
	}
}
