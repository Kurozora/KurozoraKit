//
//  UpdateProfileRequest.swift
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
/// A request that updates the authenticated user's profile information.
public struct UpdateProfileRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let update: ProfileUpdateRequest

	// MARK: - Initializers
	internal init(context: RequestContext, update: ProfileUpdateRequest) {
		self.context = context
		self.update = update
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> UserUpdateResponse {
		var parameters: [String: Any] = [:]

		if let username = self.update.username {
			parameters["username"] = username
		}
		if let nickname = self.update.nickname {
			parameters["nickname"] = nickname
		}
		if let biography = self.update.biography {
			parameters["biography"] = biography
		}
		switch self.update.profileImageRequest {
		case .update: break
		case .delete:
			parameters["profileImage"] = "null"
		case .none: break
		}
		switch self.update.bannerImageRequest {
		case .update: break
		case .delete:
			parameters["bannerImage"] = "null"
		case .none: break
		}
		if let preferredLanguage = self.update.preferredLanguage {
			parameters["preferredLanguage"] = preferredLanguage
		}
		if let preferredTVRating = self.update.preferredTVRating {
			parameters["preferredTVRating"] = preferredTVRating
		}
		if let preferredTimezone = self.update.preferredTimezone {
			parameters["preferredTimezone"] = preferredTimezone
		}

		var formData = KKMultipartFormData()

		switch self.update.profileImageRequest {
		case .update(url: let profileImageURL):
			if let profileImageURL = profileImageURL, let profileImageData = try? Data(contentsOf: profileImageURL) {
				let uploadImage: Data
				if let image = UIImage(data: profileImageData) {
					let resizedImage = image.resized(maxWidth: 400, maxHeight: 400)
					uploadImage = resizedImage.jpegData(compressionQuality: 0.8) ?? profileImageData
				} else {
					uploadImage = profileImageData
				}
				formData.append(uploadImage, withName: "profileImage", fileName: "profile.jpg", mimeType: "image/jpeg")
			}
		case .delete, .none:
			break
		}

		switch self.update.bannerImageRequest {
		case .update(url: let bannerImageURL):
			if let bannerImageURL = bannerImageURL, let bannerImageData = try? Data(contentsOf: bannerImageURL) {
				let uploadImage: Data
				if let image = UIImage(data: bannerImageData) {
					let resizedImage = image.resized(maxWidth: 1500, maxHeight: 500)
					uploadImage = resizedImage.jpegData(compressionQuality: 0.8) ?? bannerImageData
				} else {
					uploadImage = bannerImageData
				}
				formData.append(uploadImage, withName: "bannerImage", fileName: "banner.jpg", mimeType: "image/jpeg")
			}
		case .delete, .none: break
		}

		let request = KKRequest<UserUpdateResponse>(
			path: KKEndpoint.Me.update.endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.context.client.send(request)
	}
}
#endif
