//
//  ImportLibraryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation
import UniformTypeIdentifiers

/// A request that imports a library file into the authenticated user's library.
public struct ImportLibraryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let kind: LibraryKind?
	private let service: LibraryImport.Service
	private let behavior: LibraryImport.Behavior
	private let filePath: URL

	// MARK: - Initializers
	internal init(context: RequestContext, kind: LibraryKind?, service: LibraryImport.Service, behavior: LibraryImport.Behavior, filePath: URL) {
		self.context = context
		self.kind = kind
		self.service = service
		self.behavior = behavior
		self.filePath = filePath
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		var parameters: [String: Any] = [
			"service": self.service.rawValue,
			"behavior": self.behavior.rawValue
		]
		if let kind = self.kind {
			parameters["kind"] = kind.rawValue
		}

		let mimeType = UTType(filenameExtension: self.filePath.pathExtension)?.preferredMIMEType ?? "application/octet-stream"
		var formData = KKMultipartFormData()
		try formData.append(self.filePath, withName: "file", mimeType: mimeType)

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Library.import.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.context.client.send(request)
	}
}
