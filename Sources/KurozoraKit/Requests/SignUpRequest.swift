//
//  SignUpRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2026.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

#if !os(watchOS)
/// A request that creates a new user account.
public struct SignUpRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let username: String
	private let emailAddress: String
	private let password: String
	private let profileImageData: Data?

	// MARK: - Initializers
	internal init(context: RequestContext, username: String, emailAddress: String, password: String, profileImage: UIImage?) {
		self.context = context
		self.username = username
		self.emailAddress = emailAddress
		self.password = password
		self.profileImageData = profileImage?.jpegData(compressionQuality: 0.1)
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		let parameters: [String: Any] = [
			"username": self.username,
			"email": self.emailAddress,
			"password": self.password
		]

		var formData = KKMultipartFormData()
		if let imageData = self.profileImageData {
			formData.append(imageData, withName: "profileImage", fileName: "ProfileImage.png", mimeType: "image/png")
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.signUp.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.context.client.send(request)
	}
}
#endif
