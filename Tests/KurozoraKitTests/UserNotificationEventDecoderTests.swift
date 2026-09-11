//
//  UserNotificationEventDecoderTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 11/09/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

final class UserNotificationEventDecoderTests: XCTestCase {
	func testLibraryImportProgressedDecodesCounts() throws {
		let frame = KKWebSocket.Frame(
			event: "library.import.progressed",
			channel: "private-users.345",
			data: #"{"processedCount":250,"totalCount":1782}"#
		)

		let event = try XCTUnwrap(UserNotification.decodeEvent(from: frame))

		switch event {
		case .libraryImportProgressed(let processedCount, let totalCount):
			XCTAssertEqual(processedCount, 250)
			XCTAssertEqual(totalCount, 1782)
		default:
			XCTFail("Expected libraryImportProgressed, got \(event)")
		}
	}

	func testLibraryImportProgressedWithoutCountsIsDropped() {
		let frame = KKWebSocket.Frame(
			event: "library.import.progressed",
			channel: "private-users.345",
			data: #"{"processedCount":"many"}"#
		)

		XCTAssertNil(UserNotification.decodeEvent(from: frame))
	}

	func testUserStateChangedStillDecodes() throws {
		let frame = KKWebSocket.Frame(
			event: "user.state.changed",
			channel: "private-users.345",
			data: #"{"stateVersion":1478}"#
		)

		let event = try XCTUnwrap(UserNotification.decodeEvent(from: frame))

		switch event {
		case .userStateChanged(let stateVersion):
			XCTAssertEqual(stateVersion, 1478)
		default:
			XCTFail("Expected userStateChanged, got \(event)")
		}
	}
}
