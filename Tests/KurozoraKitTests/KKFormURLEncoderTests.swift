//
//  KKFormURLEncoderTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

final class KKFormURLEncoderTests: XCTestCase {
	func testEncodesSimpleStringValues() {
		let encoded = KKFormURLEncoder.encode(["name": "kirito", "id": "42"])
		// Keys are sorted alphabetically, so "id" comes before "name".
		XCTAssertEqual(encoded, "id=42&name=kirito")
	}

	func testEncodesBoolAsNumeric() {
		let encoded = KKFormURLEncoder.encode(["enabled": true, "disabled": false])
		XCTAssertEqual(encoded, "disabled=0&enabled=1")
	}

	func testEncodesArrayWithBrackets() {
		let encoded = KKFormURLEncoder.encode(["types": ["show", "game"]])
		XCTAssertEqual(encoded, "types%5B%5D=show&types%5B%5D=game")
	}

	func testEncodesIntValues() {
		let encoded = KKFormURLEncoder.encode(["limit": 25])
		XCTAssertEqual(encoded, "limit=25")
	}

	func testPercentEscapesReservedCharacters() {
		let encoded = KKFormURLEncoder.encode(["q": "hello world & friends"])
		XCTAssertEqual(encoded, "q=hello%20world%20%26%20friends")
	}
}
