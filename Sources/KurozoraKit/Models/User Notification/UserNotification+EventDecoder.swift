//
//  UserNotification+EventDecoder.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/05/2026.
//  MIT License
//

import Foundation

extension UserNotification {
	/// Decodes a realtime envelope into a typed ``UserNotification/Event``.
	internal static func decodeEvent(from envelope: KKWebSocket.Frame) -> UserNotification.Event? {
		let raw: Data = {
			guard let dataString = envelope.data else { return Data() }
			return dataString.data(using: .utf8) ?? Data()
		}()

		let decoder = JSONDecoder()

		switch envelope.event {
		case "notification.read":
			let body = (try? decoder.decode(NotificationStateChange.self, from: raw)) ?? NotificationStateChange(ids: .unknown, read: false)
			return .read(ids: body.ids.toIDs(), read: body.read ?? false)
		case "notification.deleted":
			let body = (try? decoder.decode(NotificationStateChange.self, from: raw)) ?? NotificationStateChange(ids: .unknown, read: nil)
			return .deleted(ids: body.ids.toIDs())
		default:
			break
		}

		let payload = (try? decoder.decode(UserNotification.Payload.self, from: raw))
			?? UserNotification.Payload(
				ip: nil, sessionID: nil, userID: nil, username: nil,
				profileImageURL: nil, feedMessageID: nil, message: nil, title: nil, link: nil
			)

		let typeMarker = (try? decoder.decode(TypeMarker.self, from: raw))?.type
		let effectiveType = typeMarker ?? envelope.event

		switch effectiveType {
		case "new-session": return .newSession(payload)
		case "new-follower": return .newFollower(payload)
		case "new-feed-message-reply": return .newFeedMessageReply(payload)
		case "new-feed-message-re-share": return .newFeedMessageReShare(payload)
		case "new-user-mention": return .newUserMention(payload)
		case "subscription-status": return .subscriptionStatus(payload)
		case "library-import-finished": return .libraryImportFinished(payload)
		case "library-import-unsupported": return .libraryImportUnsupported(payload)
		case "local-library-import-finished": return .localLibraryImportFinished(payload)
		default: return nil
		}
	}
}

// MARK: - Wire
private extension UserNotification {
	/// Decoder for the `type` discriminator embedded in notification creation payloads.
	struct TypeMarker: Decodable {
		let type: String
	}

	/// Decoded body of a notification state-change event.
	struct NotificationStateChange: Decodable {
		let ids: IDsWire
		let read: Bool?
	}

	/// On-wire shape of the `ids` field. This is either an array of identifiers or the literal `"all"`.
	enum IDsWire: Decodable {
		case all
		case specific([String])
		case unknown

		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let stringValue = try? container.decode(String.self) {
				self = stringValue == "all" ? .all : .unknown
			} else if let array = try? container.decode([String].self) {
				self = .specific(array)
			} else {
				self = .unknown
			}
		}

		func toIDs() -> UserNotification.IDs {
			switch self {
			case .all: return .all
			case .specific(let ids): return .specific(ids)
			case .unknown: return .specific([])
			}
		}
	}
}
