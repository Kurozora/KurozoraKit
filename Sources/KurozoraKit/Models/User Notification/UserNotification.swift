//
//  Notification.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/10/2018.
//  MIT License
//

import Foundation

/// A root object that stores information about a user notification resource.
public final class UserNotification: KurozoraItem, IdentityResource, Hashable, @unchecked Sendable {
	// MARK: - Properties
	public let id: KurozoraItemID

	public let type: String

	public let href: String

	/// The attributes belonging to the user notification.
	public var attributes: UserNotification.Attributes

	// MARK: - Functions
	public static func == (lhs: UserNotification, rhs: UserNotification) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}
}

// MARK: - Realtime events
extension UserNotification {
	/// A typed realtime event delivered on the user notification channel.
	public enum Event: Sendable {
		/// A `new-session` broadcast.
		case newSession(UserNotification.Payload)

		/// A `new-follower` broadcast.
		case newFollower(UserNotification.Payload)

		/// A `new-feed-message-reply` broadcast.
		case newFeedMessageReply(UserNotification.Payload)

		/// A `new-feed-message-re-share` broadcast.
		case newFeedMessageReShare(UserNotification.Payload)

		/// A `new-user-mention` broadcast.
		case newUserMention(UserNotification.Payload)

		/// A `subscription-status` broadcast.
		case subscriptionStatus(UserNotification.Payload)

		/// A `library-import-finished` broadcast.
		case libraryImportFinished(UserNotification.Payload)

		/// A `library-import-unsupported` broadcast.
		case libraryImportUnsupported(UserNotification.Payload)

		/// A `local-library-import-finished` broadcast.
		case localLibraryImportFinished(UserNotification.Payload)

		/// A `notification.read` broadcast.
		case read(ids: IDs, read: Bool)

		/// A `notification.deleted` broadcast.
		case deleted(ids: IDs)
	}

	/// The set of notification identifiers affected by a state change event.
	public enum IDs: Sendable, Equatable {
		/// An explicit list of identifiers.
		case specific([String])

		/// Every notification belonging to the user.
		case all
	}
}
