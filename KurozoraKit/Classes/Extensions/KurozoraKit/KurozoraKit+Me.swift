//
//  KurozoraKit+Me.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//

import TRON
import UIKit

extension KurozoraKit {
	/// Fetches the authenticated user's profile details.
	///
	/// - Parameters:
	///    - completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
	///    - result: A value that represents either a success or a failure, including an associated value in each case.
	public func getProfileDetails(completion completionHandler: @escaping (_ result: Result<[User], KKAPIError>) -> Void) {
		let meProfile = KKEndpoint.Me.profile.endpointValue
		let request: APIRequest<UserResponse, KKAPIError> = tron.codable.request(meProfile)

		request.headers = headers
		request.headers.add(.authorization(bearerToken: self.authenticationKey))

		request.method = .get
		request.perform(withSuccess: { userResponse in
			User.current = userResponse.data.first
			completionHandler(.success(userResponse.data))
//			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				UIApplication.topViewController?.presentAlertController(title: "Can't Get Profile Details 😔", message: error.message)
			}
			print("❌ Received get profile details error", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/// Updates the authenticated user's profile information.
	///
	/// Send `nil` if an infomration shouldn't be updated, otherwise send an empty instance to unset an information.
	///
	/// - Parameters:
	///    - biography: The user's new biography.
	///    - profileImage: The user's new profile image.
	///    - bannerImage: The user's new profile image.
	///    - username: The user's new username.
	///
	/// - Returns: An instance of `RequestSender` with the results of the update information response.
	public func updateInformation(_ profileUpdateRequest: ProfileUpdateRequest) -> RequestSender<UserUpdateResponse, KKAPIError> {
		// Prepare headers
		var headers: HTTPHeaders = [
			.contentType("multipart/form-data"),
			.accept("application/json"),
			.authorization(bearerToken: self.authenticationKey)
		]
		var parameters: [String: Any] = [:]

		if let username = profileUpdateRequest.username {
			parameters["username"] = username
		}
		if let username = profileUpdateRequest.nickname {
			parameters["nickname"] = username
		}
		if let biography = profileUpdateRequest.biography {
			parameters["biography"] = biography
		}
		if profileUpdateRequest.profileImage == nil {
			parameters["profileImage"] = "null"
		}
		if profileUpdateRequest.bannerImage == nil {
			parameters["bannerImage"] = "null"
		}

		// Prepare request
		let usersProfile = KKEndpoint.Me.update.endpointValue
		let request: UploadAPIRequest<UserUpdateResponse, KKAPIError> = tron.codable.uploadMultipart(usersProfile) { formData in
			if let profileImageURL = profileUpdateRequest.profileImage, let profileImageData = try? Data(contentsOf: profileImageURL) {
				let pathExtension = profileImageURL.pathExtension
				var uploadImage: Data!

				switch pathExtension {
				case "jpeg", "jpg", "png":
					uploadImage = UIImage(data: profileImageData)?.jpegData(compressionQuality: 0.1) ?? profileImageData
				default:
					uploadImage = profileImageData
				}

				formData.append(uploadImage, withName: "profileImage", fileName: profileImageURL.lastPathComponent, mimeType: "image/\(pathExtension)")
			}
			if let bannerImageURL = profileUpdateRequest.bannerImage, let bannerImageData = try? Data(contentsOf: bannerImageURL) {
				let pathExtension = bannerImageURL.pathExtension
				var uploadImage: Data!

				switch pathExtension {
				case "jpeg", "jpg", "png":
					uploadImage = UIImage(data: bannerImageData)?.jpegData(compressionQuality: 0.1) ?? bannerImageData
				default:
					uploadImage = bannerImageData
				}

				formData.append(uploadImage, withName: "bannerImage", fileName: bannerImageURL.lastPathComponent, mimeType: "image/\(pathExtension)")
			}
		}
			.method(.post)
			.parameters(parameters)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the followers or following list for the authenticated user.
	///
	/// - Parameters:
	///    - followList: The follow list value indicating whather to fetch the followers or following list.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///    - completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
	///    - result: A value that represents either a success or a failure, including an associated value in each case.
	public func getFollowList(_ followList: UsersListType, next: String? = nil, limit: Int = 25, completion completionHandler: @escaping (_ result: Result<UserIdentityResponse, KKAPIError>) -> Void) {
		let meFollowersOrFollowing = next ?? (followList == .followers ? KKEndpoint.Me.followers.endpointValue : KKEndpoint.Me.following.endpointValue)
		let request: APIRequest<UserIdentityResponse, KKAPIError> = tron.codable.request(meFollowersOrFollowing).buildURL(.relativeToBaseURL)

		request.headers = headers
		request.headers.add(.authorization(bearerToken: self.authenticationKey))

		request.parameters["limit"] = limit

		request.method = .get
		request.perform(withSuccess: { userIdentityResponse in
			completionHandler(.success(userIdentityResponse))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				UIApplication.topViewController?.presentAlertController(title: "Can't Get \(followList.rawValue.capitalized) List 😔", message: error.message)
			}
			print("❌ Received get \(followList.rawValue) error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}
}
