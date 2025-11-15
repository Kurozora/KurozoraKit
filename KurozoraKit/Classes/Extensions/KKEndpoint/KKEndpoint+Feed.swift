//
//  KKEndpoint+Feed.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/08/2020.
//

// MARK: - Messages
extension KKEndpoint.Feed {
	/// The set of available Messages API endpoints types.
	internal enum Messages {
		// MARK: - Cases
		/// The endpoint to the message details.
		case details(_ messageIdentity: KurozoraItem)

		/// The endpoint to update the message details.
		case update(_ messageIdentity: KurozoraItem)

		/// The endpoint to heart or unheart a feed message.
		case heart(_ messageIdentity: KurozoraItem)

		/// The endpoint to pin or unpin a feed message.
		case pin(_ messageIdentity: KurozoraItem)

		/// The endpoint to the replies of a feed message.
		case replies(_ messageIdentity: KurozoraItem)

		/// The endpoint to delete the message details.
		case delete(_ messageIdentity: KurozoraItem)

		// MARK: - Properties
		/// The endpoint value of the Messages API type.
		var endpointValue: String {
			switch self {
			case .details(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)"
			case .update(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)/update"
			case .heart(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)/heart"
			case .pin(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)/pin"
			case .replies(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)/replies"
			case .delete(let messageIdentity):
				return "feed/messages/\(messageIdentity.id)/delete"
			}
		}
	}
}
