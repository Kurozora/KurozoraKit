//
//  UserNotificationData.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2020.
//

extension UserNotification {
	/// A root object that stores information about user notification payload.
	public struct Payload: Codable {
		// MARK: - Properties
		// Session
		/// [Session] The ip address of a session.
		public let ip: String?

		/// [Session] The id of a session.
		public let sessionID: Int?

		// Follower
		/// [Follower] The id of a follower.
		public let userID: Int?

		/// [Follower] The nickname of a follower.
		public let nickname: String?

		/// [Follower] The profile image of the follower.
		public let profileImageURL: String?

		// Feed Message
		/// [FeedMessage] The id of a feed message.
		public let feedMessageID: Int?
	}
}
