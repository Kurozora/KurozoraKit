//
//  KKMultipartFormData.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// A builder for `multipart/form-data` request bodies.
///
/// Append `Data` or file-URL parts with a name, optional filename, and optional
/// MIME type, then call ``encode(parameters:)`` to render the accumulated parts
/// into a single `Data` blob. Use ``contentType`` for the matching header value.
internal struct KKMultipartFormData {
	// MARK: - Part
	/// A single part of the multipart body.
	fileprivate struct Part {
		let name: String
		let fileName: String?
		let mimeType: String?
		let data: Data
	}

	// MARK: - Properties
	/// The boundary string used to separate parts in the rendered body.
	let boundary: String

	/// The `Content-Type` header value to use for the request, including the boundary.
	var contentType: String { "multipart/form-data; boundary=\(self.boundary)" }

	private var parts: [Part] = []

	// MARK: - Initializer
	/// Creates a new multipart form builder with a random, RFC-safe boundary.
	init(boundary: String = "KurozoraKit.Boundary.\(UUID().uuidString)") {
		self.boundary = boundary
	}

	// MARK: - Append
	/// Appends a data part to the body.
	mutating func append(_ data: Data, withName name: String, fileName: String? = nil, mimeType: String? = nil) {
		self.parts.append(Part(name: name, fileName: fileName, mimeType: mimeType, data: data))
	}

	/// Appends the contents of a file URL as a part. Throws if the file cannot be read.
	mutating func append(_ fileURL: URL, withName name: String, fileName: String? = nil, mimeType: String? = nil) throws {
		let data = try Data(contentsOf: fileURL)
		let resolvedFileName = fileName ?? fileURL.lastPathComponent
		self.append(data, withName: name, fileName: resolvedFileName, mimeType: mimeType)
	}

	// MARK: - Encode
	/// Renders the accumulated parts (plus any text `parameters`) into a single `Data` blob.
	///
	/// Text parameters are serialized as `form-data` parts ordered before file parts.
	func encode(parameters: [String: Any] = [:]) -> Data {
		var body = Data()
		let boundaryPrefix = "--\(self.boundary)\r\n"
		let boundarySuffix = "\r\n"

		// Text parameters first — sorted for deterministic output.
		for (key, value) in parameters.sorted(by: { $0.key < $1.key }) {
			body.append(boundaryPrefix)
			body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
			body.append("\(value)")
			body.append(boundarySuffix)
		}

		// File / data parts.
		for part in self.parts {
			body.append(boundaryPrefix)

			var disposition = "Content-Disposition: form-data; name=\"\(part.name)\""
			if let fileName = part.fileName {
				disposition += "; filename=\"\(fileName)\""
			}
			body.append("\(disposition)\r\n")

			if let mimeType = part.mimeType {
				body.append("Content-Type: \(mimeType)\r\n")
			}

			body.append("\r\n")
			body.append(part.data)
			body.append(boundarySuffix)
		}

		// Closing boundary.
		body.append("--\(self.boundary)--\r\n")
		return body
	}
}

// MARK: - Data convenience
private extension Data {
	mutating func append(_ string: String) {
		if let data = string.data(using: .utf8) {
			self.append(data)
		}
	}
}
