//
//  KurozoraKit+Me.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//

import TRON
import SCLAlertView

extension KurozoraKit {
	/**
		Fetches and restores the details for the authenticated user.

		- Parameter authenticationKey: The authentication key of the user whose details should be fetched.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func restoreDetails(forUserWith authenticationKey: String, completion completionHandler: @escaping (_ result: Result<String, KKAPIError>) -> Void) {
		let meProfile = KKEndpoint.Me.profile.endpointValue
		let request: APIRequest<SignInResponse, KKAPIError> = tron.codable.request(meProfile)

		request.headers = headers
		request.headers["kuro-auth"] = authenticationKey

		request.method = .get
		request.perform(withSuccess: { [weak self] signInResponse in
			guard let self = self else { return }
			self.authenticationKey = signInResponse.authToken
			User.current = signInResponse.data.first
			completionHandler(.success(self.authenticationKey))
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get details 😔", subTitle: error.message)
			}
			print("❌ Received restore details error", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Update the authenticated user's profile information.

		- Parameter biography: The new biography to set.
		- Parameter profileImage: The new user's profile image.
		- Parameter bannerImage: The new user's profile image.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func updateInformation(biography: String? = nil, profileImage: UIImage? = nil, bannerImage: UIImage? = nil, completion completionHandler: @escaping (_ result: Result<UserUpdate, KKAPIError>) -> Void) {
		let usersProfile = KKEndpoint.Me.update.endpointValue
		let request: UploadAPIRequest<UserUpdateResponse, KKAPIError> = tron.codable.uploadMultipart(usersProfile) { formData in
			if let profileImage = profileImage {
				if profileImage.size.width != 0 {
					if let profileImageData = profileImage.jpegData(compressionQuality: 0.1) {
						formData.append(profileImageData, withName: "profileImage", fileName: "ProfileImage.png", mimeType: "image/png")
					}
				}
			}
			if let bannerImage = bannerImage {
				if bannerImage.size.width != 0 {
					if let bannerImageData = bannerImage.jpegData(compressionQuality: 0.1) {
						formData.append(bannerImageData, withName: "bannerImage", fileName: "BannerImage.png", mimeType: "image/png")
					}
				}
			}
		}

		request.headers = [
			"Content-Type": "multipart/form-data"
		]
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .post
		if let biography = biography {
			if !biography.isEmpty {
				request.parameters["biography"] = biography
			}
		} else {
			request.parameters["biography"] = NSNull()
		}
		if profileImage == nil {
			request.parameters["profileImage"] = NSNull()
		}
		if bannerImage == nil {
			request.parameters["bannerImage"] = NSNull()
		}

		request.perform(withSuccess: { [weak self] userUpdateResponse in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showSuccess("Settings updated ☺️", subTitle: userUpdateResponse.message)
			}

			User.current?.attributes.update(using: userUpdateResponse.data)
			completionHandler(.success(userUpdateResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			UIView().endEditing(true)
			if self.services.showAlerts {
				SCLAlertView().showError("Can't update information 😔", subTitle: error.message)
			}
			print("❌ Received update profile information error", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch the followers or following list for the authenticated user.

		- Parameter followList: The follow list value indicating whather to fetch the followers or following list.
		- Parameter next: The URL string of the next page in the paginated response. Use `nil` to get first page.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getFollowList(_ followList: FollowList, next: String? = nil, completion completionHandler: @escaping (_ result: Result<UserFollow, KKAPIError>) -> Void) {
		let meFollowersOrFollowing = next ?? (followList == .followers ? KKEndpoint.Me.followers.endpointValue : KKEndpoint.Me.following.endpointValue)
		let request: APIRequest<UserFollow, KKAPIError> = tron.codable.request(meFollowersOrFollowing).buildURL(.relativeToBaseURL)

		request.headers = headers
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .get
		request.perform(withSuccess: { userFollow in
			completionHandler(.success(userFollow))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get \(followList.rawValue) list 😔", subTitle: error.message)
			}
			print("❌ Received get \(followList.rawValue) error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}
}
