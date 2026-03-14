//
//  KurozoraKit+Me.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

extension KurozoraKit {
	/// Fetches the authenticated user's profile details.
	///
	/// - Returns: A ``UserResponse`` with the authenticated user's profile details.
	public func getProfileDetails() async throws -> UserResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<UserResponse>(
			path: KKEndpoint.Me.profile.endpointValue,
			method: .get,
			headers: headers
		)

		do {
			let userResponse = try await self.client.send(request)
			User.current = userResponse.data.first
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
			return userResponse
		} catch {
			print("Received profile details error: \(error.localizedDescription)")
			throw error
		}
	}

	#if !os(watchOS)
	/// Updates the authenticated user's profile information.
	///
	/// Pass `nil` for fields that should remain unchanged, or an empty value to clear a field.
	///
	/// - Parameter profileUpdateRequest: An instance of `ProfileUpdateRequest` containing the new profile details.
	///
	/// - Returns: A ``UserUpdateResponse`` with the updated profile information.
	public func updateInformation(_ profileUpdateRequest: ProfileUpdateRequest) async throws -> UserUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		// Prepare parameters
		var parameters: [String: Any] = [:]

		if let username = profileUpdateRequest.username {
			parameters["username"] = username
		}
		if let nickname = profileUpdateRequest.nickname {
			parameters["nickname"] = nickname
		}
		if let biography = profileUpdateRequest.biography {
			parameters["biography"] = biography
		}
		switch profileUpdateRequest.profileImageRequest {
		case .update: break
		case .delete:
			parameters["profileImage"] = "null"
		case .none: break
		}
		switch profileUpdateRequest.bannerImageRequest {
		case .update: break
		case .delete:
			parameters["bannerImage"] = "null"
		case .none: break
		}
		if let preferredLanguage = profileUpdateRequest.preferredLanguage {
			parameters["preferredLanguage"] = preferredLanguage
		}
		if let preferredTVRating = profileUpdateRequest.preferredTVRating {
			parameters["preferredTVRating"] = preferredTVRating
		}
		if let preferredTimezone = profileUpdateRequest.preferredTimezone {
			parameters["preferredTimezone"] = preferredTimezone
		}

		// Build multipart form
		var formData = KKMultipartFormData()

		switch profileUpdateRequest.profileImageRequest {
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

		switch profileUpdateRequest.bannerImageRequest {
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
			headers: headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.client.send(request)
	}
	#endif

	/// Fetches the followers or following list for the authenticated user.
	///
	/// - Parameters:
	///    - followList: The type of list to fetch (followers or following).
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``UserIdentityResponse`` with the list of user identities.
	public func getFollowList(_ followList: UsersListType, next: String? = nil, limit: Int = 25) async throws -> UserIdentityResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let path = next ?? (followList == .followers ? KKEndpoint.Me.followers.endpointValue : KKEndpoint.Me.following.endpointValue)
		let request = KKRequest<UserIdentityResponse>(
			path: path,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the list of up-next episodes for the authenticated user.
	///
	/// - Parameters:
	///    - showIdentity: The identity of a show to scope the up-next list to. Use `nil` to fetch across all shows.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An ``EpisodeIdentityResponse`` with the list of up-next episode identities.
	public func getUpNextEpisodes(for showIdentity: ShowIdentity? = nil, next: String? = nil, limit: Int = 25) async throws -> EpisodeIdentityResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"limit": limit
		]
		if let showIdentity = showIdentity {
			parameters["model_id"] = showIdentity.id
		}

		let request = KKRequest<EpisodeIdentityResponse>(
			path: next ?? KKEndpoint.Me.Episodes.upNext.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}
}
