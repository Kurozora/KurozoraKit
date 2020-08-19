//
//  KurozoraKit+User.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  Copyright © 2019 Kurozora. All rights reserved.
//

import TRON
import SCLAlertView

extension KurozoraKit {
	/**
		Sign up a new account with the given details.

		- Parameter username: The new user's username.
		- Parameter password: The new user's password.
		- Parameter emailAddress: The new user's email address.
		- Parameter profileImage: The new user's profile image.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func signUp(withUsername username: String, emailAddress: String, password: String, profileImage: UIImage?, completion completionHandler: @escaping (_ result: Result<String, KKAPIError>) -> Void) {
		let usersSignUp = KKEndpoint.Users.signUp.endpointValue
		let request: UploadAPIRequest<SignInResponse, KKAPIError> = tron.codable.uploadMultipart(usersSignUp) { (formData) in
			if let profileImage = profileImage?.jpegData(compressionQuality: 0.1) {
				formData.append(profileImage, withName: "profileImage", fileName: "ProfileImage.png", mimeType: "image/png")
			}
		}
		request.headers = [
			"Content-Type": "multipart/form-data"
		]
		request.method = .post
		request.parameters = [
			"username": username,
			"email": emailAddress,
			"password": password
		]
		request.perform(withSuccess: { [weak self] signInResponse in
			guard let self = self else { return }
			self.authenticationKey = signInResponse.authToken
			User.current = signInResponse.data.first
			completionHandler(.success(self.authenticationKey))
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't sign up account 😔", subTitle: error.message)
			}
			print("Received sign up account error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Sign in with the given `kurozoraID` and `password`.

		This endpoint is used for signing in a user to their account. If the sign in was successful then a Kurozora authentication token is returned in the success closure.

		- Parameter kurozoraID: The Kurozora id of the user to be signed in.
		- Parameter password: The password of the user to be signed in.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func signIn(_ kurozoraID: String, _ password: String, completion completionHandler: @escaping (_ result: Result<String, KKAPIError>) -> Void) {
		let usersSignIn = KKEndpoint.Users.signIn.endpointValue
		let request: APIRequest<SignInResponse, KKAPIError> = tron.codable.request(usersSignIn)
		request.headers = headers
		request.method = .post
		request.parameters = [
			"email": kurozoraID,
			"password": password,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]

		request.perform(withSuccess: { [weak self] signInResponse in
			guard let self = self else { return }
			self.authenticationKey = signInResponse.authToken
			User.current = signInResponse.data.first
			completionHandler(.success(self.authenticationKey))
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't sign in 😔", subTitle: error.message)
			}
			print("❌ Received sign in error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Sign up a new account and sign in using the details from Sign in with Apple.

		After the new account has been created successfully the user is signed in immediately. A notification with the `KUserIsSignedInDidChange` name is posted.
		This notification can be observed to perform UI changes regarding the user's sign in status. For example you can remove buttons the user should not have access to if not signed in.

		- Parameter userID: The user's id returned by Sign in with Apple.
		- Parameter emailAddress: The user's email returned by Sign in with Apple.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func signUp(withAppleUserID userID: String, emailAddress: String, completion completionHandler: @escaping (_ result: Result<String, KKAPIError>) -> Void) {
		let usersSignUpSIWA = KKEndpoint.Users.signUpSIWA.endpointValue
		let request: APIRequest<SignInResponse, KKAPIError> = tron.codable.request(usersSignUpSIWA)
		request.headers = headers
		request.method = .post
		request.parameters = [
			"email": emailAddress,
			"siwa_id": userID
		]
		request.perform(withSuccess: { [weak self] signInResponse in
			guard let self = self else { return }
//			try? self.services._keychainDefaults.set("\(userID)", key: "siwa_id")
//			self.services.processUserData(fromSession: userSession)
			self.authenticationKey = signInResponse.authToken
			User.current = signInResponse.data.first
			completionHandler(.success(self.authenticationKey))
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			UIView().endEditing(true)
			if self.services.showAlerts {
				SCLAlertView().showError("Can't sign up account 😔", subTitle: error.message)
			}
			print("Received sign up account with SIWA error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Sign in users to their account using Sign in with Apple.

		After the user is signed in successfully, a notification with the `KUserIsSignedInDidChange` name is posted.
		This notification can be observed to perform UI changes regarding the user's sign in status. For example you can remove buttons the user should not have access to if not signed in.

		- Parameter idToken: A JSON Web Token (JWT) that securely communicates information about the user to the server.
		- Parameter authorizationCode: A short-lived token used by the app for proof of authorization when interacting with the server.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func signInWithApple(usingIDToken idToken: String, authorizationCode: String, completion completionHandler: @escaping (_ result: Result<String, KKAPIError>) -> Void) {
		let usersSigninSIWA = KKEndpoint.Users.signInSIWA.endpointValue
		let request: APIRequest<SignInResponse, KKAPIError> = tron.codable.request(usersSigninSIWA)
		request.headers = headers
		request.method = .post
		request.parameters = [
			"identity_token": idToken,
			"auth_code": authorizationCode
		]
		request.perform(withSuccess: { [weak self] signInResponse in
			guard let self = self else { return }
//			try? KKServices.shared.KeychainDefaults.set(idToken, key: "SIWA_id_token")
//			KKServices.shared.processUserData(fromSession: userSession)
			self.authenticationKey = signInResponse.authToken
			User.current = signInResponse.data.first
			completionHandler(.success(signInResponse.authToken))
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't sign in with Apple 😔", subTitle: error.message)
			}
			print("Received sign in with Apple error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Request a password reset link for the given email address.

		- Parameter emailAddress: The email address to which the reset link should be sent.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func resetPassword(withEmailAddress emailAddress: String, completion completionHandler: @escaping (_ result: Result<KKSuccess, KKAPIError>) -> Void) {
		let usersResetPassword = KKEndpoint.Users.resetPassword.endpointValue
		let request: APIRequest<KKSuccess, KKAPIError> = tron.codable.request(usersResetPassword)
		request.headers = headers
		request.method = .post
		request.parameters = [
			"email": emailAddress
		]
		request.perform(withSuccess: { success in
			completionHandler(.success(success))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			UIView().endEditing(true)
			if self.services.showAlerts {
				SCLAlertView().showError("Can't send reset link 😔", subTitle: error.message)
			}
			print("Received reset password error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch the followers or following list for the current user.

		- Parameter userID: The id of the user whose follower or following list should be fetched.
		- Parameter followList: The follow list value indicating whather to fetch the followers or following list.
		- Parameter next: The URL string of the next page in the paginated response. Use `nil` to get first page.
		- Parameter limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getFollowList(forUserID userID: Int, _ followList: FollowList, next: String? = nil, limit: Int = 25, completion completionHandler: @escaping (_ result: Result<UserFollow, KKAPIError>) -> Void) {
		let usersFollowerOrFollowing = next ?? (followList == .following ? KKEndpoint.Users.following(userID).endpointValue : KKEndpoint.Users.followers(userID).endpointValue)
		let request: APIRequest<UserFollow, KKAPIError> = tron.codable.request(usersFollowerOrFollowing).buildURL(.relativeToBaseURL)

		request.headers = headers
		if User.isSignedIn {
			request.headers["kuro-auth"] = self.authenticationKey
		}

		request.parameters["limit"] = limit

		request.method = .get
		request.perform(withSuccess: { userFollow in
			completionHandler(.success(userFollow))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get \(followList.rawValue) list 😔", subTitle: error.message)
			}
			print("Received get \(followList.rawValue) error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Follow or unfollow a user with the given user id.

		- Parameter userID: The id of the user to follow/unfollow.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func updateFollowStatus(forUserID userID: Int, completion completionHandler: @escaping (_ result: Result<FollowUpdate, KKAPIError>) -> Void) {
		let usersFollow = KKEndpoint.Users.follow(userID).endpointValue
		let request: APIRequest<FollowUpdateResponse, KKAPIError> = tron.codable.request(usersFollow)

		request.headers = headers
		if User.isSignedIn {
			request.headers["kuro-auth"] = self.authenticationKey
		}

		request.method = .post
		request.perform(withSuccess: { followUpdateResponse in
			completionHandler(.success(followUpdateResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't follow user 😔", subTitle: error.message)
			}
			print("Received follow user error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch the favorite shows list for the given user.

		- Parameter userID: The id of the user whose favorite list will be fetched.
		- Parameter next: The URL string of the next page in the paginated response. Use `nil` to get first page.
		- Parameter limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getFavoriteShows(forUserID userID: Int, next: String? = nil, limit: Int = 25, completion completionHandler: @escaping (_ result: Result<ShowResponse, KKAPIError>) -> Void) {
		let usersFavoriteShow = next ?? KKEndpoint.Users.favoriteShow(userID).endpointValue
		let request: APIRequest<ShowResponse, KKAPIError> = tron.codable.request(usersFavoriteShow).buildURL(.relativeToBaseURL)

		request.headers = headers
		if User.isSignedIn {
			request.headers["kuro-auth"] = self.authenticationKey
		}

		request.parameters["limit"] = limit

		request.method = .get
		request.perform(withSuccess: { showResponse in
			completionHandler(.success(showResponse))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get favorites list 😔", subTitle: error.message)
			}
			print("Received get favorites error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch the profile details of the given user id.

		- Parameter userID: The id of the user whose profile details should be fetched.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getProfile(forUserID userID: Int, completion completionHandler: @escaping (_ result: Result<[User], KKAPIError>) -> Void) {
		let usersProfile = KKEndpoint.Users.profile(userID).endpointValue
		let request: APIRequest<UserResponse, KKAPIError> = tron.codable.request(usersProfile)

		request.headers = headers
		if User.isSignedIn {
			request.headers["kuro-auth"] = self.authenticationKey
		}

		request.method = .get
		request.perform(withSuccess: { userResponse in
			completionHandler(.success(userResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get user details 😔", subTitle: error.message)
			}
			print("Received user profile error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch a list of users matching the search query.

		- Parameter username: The search query by which the search list should be fetched.
		- Parameter successHandler: A closure returning a SearchElement array.
		- Parameter search: The returned SearchElement array.
	*/
	public func search(forUsername username: String, completion completionHandler: @escaping (_ result: Result<[User], KKAPIError>) -> Void) {
		let usersSearch = KKEndpoint.Users.search.endpointValue
		let request: APIRequest<UserResponse, KKAPIError> = tron.codable.request(usersSearch)

		request.headers = headers
		if User.isSignedIn {
			request.headers["kuro-auth"] = self.authenticationKey
		}

		request.method = .get
		request.parameters = [
			"query": username
		]
		request.perform(withSuccess: { userResponse in
			completionHandler(.success(userResponse.data))
		}, failure: { error in
//			if self.services.showAlerts {
//				SCLAlertView().showError("Can't get search results 😔", subTitle: error.message)
//			}
			print("Received user search error: \(error.message ?? "No message available")")
			completionHandler(.failure(error))
		})
	}
}
