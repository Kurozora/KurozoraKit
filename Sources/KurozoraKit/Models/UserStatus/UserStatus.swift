//
//  UserStatus.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/05/2026.
//  MIT License
//

import Foundation

/// A namespace for realtime user activity status events delivered on the user status channel.
public enum UserStatus {
	/// A typed realtime event reporting an activity status transition for a single user.
	public struct Event: Sendable, Equatable {
		// MARK: - Properties
		/// The identifier of the user whose status changed.
		public let id: Int

		/// The activity status after the transition.
		public let status: ActivityStatus

		// MARK: - Initializers
		/// Creates an event with the given user identifier and resolved activity status.
		///
		/// - Parameters:
		///    - id: The identifier of the user whose status changed.
		///    - status: The activity status after the transition.
		public init(id: Int, status: ActivityStatus) {
			self.id = id
			self.status = status
		}
	}

	/// Decodes a realtime envelope into a typed ``UserStatus/Event``.
	///
	/// - Parameter envelope: The realtime frame received on a user status channel.
	///
	/// - Returns: A typed event when the frame is a recognised `user.status.changed` payload, otherwise `nil`.
	internal static func decodeEvent(from envelope: KKWebSocket.Frame) -> UserStatus.Event? {
		guard envelope.event == "user.status.changed" else { return nil }
		guard let dataString = envelope.data, let dataBytes = dataString.data(using: .utf8) else { return nil }
		guard let payload = try? JSONDecoder().decode(Payload.self, from: dataBytes) else { return nil }
		guard let status = ActivityStatus(rawValue: payload.status) else { return nil }

		return UserStatus.Event(id: payload.id, status: status)
	}
}

// MARK: - Wire
private extension UserStatus {
	/// The payload shape of a `user.status.changed` broadcast.
	struct Payload: Decodable {
		let id: Int
		let status: Int
	}
}
