//
//  KKMultipartFormDataTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

final class KKMultipartFormDataTests: XCTestCase {
	func testContentTypeIncludesBoundary() {
		let form = KKMultipartFormData(boundary: "TEST_BOUNDARY")
		XCTAssertEqual(form.contentType, "multipart/form-data; boundary=TEST_BOUNDARY")
	}

	func testEncodesTextParametersBeforeFiles() {
		var form = KKMultipartFormData(boundary: "B")
		form.append(Data("filebody".utf8), withName: "file", fileName: "note.txt", mimeType: "text/plain")

		let encoded = form.encode(parameters: ["username": "kirito"])
		let rendered = String(data: encoded, encoding: .utf8) ?? ""

		// Parameters come first (alphabetically), then file parts.
		XCTAssertTrue(rendered.hasPrefix("--B\r\nContent-Disposition: form-data; name=\"username\"\r\n\r\nkirito\r\n"), "Expected username part first; got:\n\(rendered)")
		XCTAssertTrue(rendered.contains("--B\r\nContent-Disposition: form-data; name=\"file\"; filename=\"note.txt\"\r\nContent-Type: text/plain\r\n\r\nfilebody\r\n"), "Expected file part; got:\n\(rendered)")
		XCTAssertTrue(rendered.hasSuffix("--B--\r\n"), "Expected closing boundary; got:\n\(rendered)")
	}

	func testBoundaryIsUniquePerInstance() {
		let first = KKMultipartFormData()
		let second = KKMultipartFormData()
		XCTAssertNotEqual(first.boundary, second.boundary)
	}
}
