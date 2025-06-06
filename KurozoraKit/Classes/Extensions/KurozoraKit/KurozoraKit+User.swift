//
//  KurozoraKit+Users.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//

import Alamofire
import TRON

extension KurozoraKit {
	/// Sign up a new account with the given details.
	///
	/// - Parameters:
	///    - username: The new user's username.
	///    - password: The new user's password.
	///    - emailAddress: The new user's email address.
	///    - profileImage: The new user's profile image.
	///
	/// - Returns: An instance of `RequestSender` with the results of the sign up response.
	public func signUp(withUsername username: String, emailAddress: String, password: String, profileImage: UIImage?) -> RequestSender<KKSuccess, KKAPIError> {
		// Prepare headers
		let headers: HTTPHeaders = [
			.contentType("multipart/form-data")
		]

		// Prepare parameters
		let parameters = [
			"username": username,
			"email": emailAddress,
			"password": password
		]

		// Prepare request
		let usersSignUp = KKEndpoint.Users.signUp.endpointValue
		let request: UploadAPIRequest<KKSuccess, KKAPIError> = tron.codable.uploadMultipart(usersSignUp) { (formData) in
			if let profileImage = profileImage?.jpegData(compressionQuality: 0.1) {
				formData.append(profileImage, withName: "profileImage", fileName: "ProfileImage.png", mimeType: "image/png")
			}
		}
		.method(.post)
		.parameters(parameters)
		.headers(headers)

		// Send request
		return request.sender()
	}

	/// Sign in with the given `email` and `password`.
	///
	/// This endpoint is used for signing in a user to their account.
	/// If the sign in was successful then a Kurozora authentication
	/// token is returned in the success closure.
	///
	/// - Parameters:
	///    - email: The email address of the user to be signed in.
	///    - password: The password of the user to be signed in.
	///
	/// - Returns: An instance of ``SignInResponse`` with the results of the sign in response.
	public func signIn(_ email: String, _ password: String) async throws -> SignInResponse {
		let usersSignIn = KKEndpoint.Users.signIn.endpointValue
		let request: APIRequest<SignInResponse, KKAPIError> = tron.codable.request(usersSignIn)
		request.headers = headers
		request.method = .post
		request.parameters = await [
			"email": email,
			"password": password,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]

		do {
			let signInResponse = try await request.sender().value

			self.authenticationKey = signInResponse.authenticationToken
			User.current = signInResponse.data.first
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)

			return signInResponse
		} catch let error as KKAPIError {
			print("❌ Received sign in error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message)
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			throw error
		} catch {
			print("❌ Received sign in error:", error.localizedDescription)
			throw error
		}
	}

	/// Sign in or up an account using the details from Sign in with Apple.
	///
	/// If a new account is created, the response will ask for the user to provide a username.
	///
	/// If an account exists, the user is signed in and a notification with the `KUserIsSignedInDidChange` name is posted.
	/// This notification can be observed to perform UI changes regarding the user's sign in status. For example you can remove buttons the user should not have access to if not signed in.
	///
	/// - Parameters:
	///    - token: A JSON Web Token (JWT) that securely communicates information about the user to the server.
	///
	/// - Returns: An instance of ``OAuthResponse`` with the results of the sign in response.
	public func signIn(withAppleID token: String) async throws -> OAuthResponse {
		let siwaSignIn = KKEndpoint.Users.siwaSignIn.endpointValue
		let request: APIRequest<OAuthResponse, KKAPIError> = tron.codable.request(siwaSignIn)
		request.headers = headers
		request.method = .post
		request.parameters = await [
			"token": token,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName
		]

		do {
			let oAuthResponse = try await request.sender().value

			self.authenticationKey = oAuthResponse.authenticationToken
			User.current = oAuthResponse.data?.first
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)

			return oAuthResponse
		} catch let error as KKAPIError {
			print("❌ Received sign in with SIWA error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message)
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			throw error
		} catch {
			print("❌ Received sign in with SIWA error:", error.localizedDescription)
			throw error
		}
	}

	/// Request a password reset link for the given email address.
	///
	/// - Parameters:
	///    - emailAddress: The email address to which the reset link should be sent.
	///
	/// - Returns: An instance of `RequestSender` with the results of the reset password response.
	public func resetPassword(withEmailAddress emailAddress: String) -> RequestSender<KKSuccess, KKAPIError> {
		// Prepare headers
		let headers = self.headers

		// Prepare parameters
		let parameters = [
			"email": emailAddress
		]

		// Prepare request
		let usersResetPassword = KKEndpoint.Users.resetPassword.endpointValue
		let request: APIRequest<KKSuccess, KKAPIError> = tron.codable.request(usersResetPassword)
			.method(.post)
			.parameters(parameters)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the followers or following list for the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose follower or following list should be fetched.
	///    - followList: The follow list value indicating weather to fetch the followers or following list.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get follow list response.
	public func getFollowList(forUser userIdentity: UserIdentity, _ followList: UsersListType, next: String? = nil, limit: Int = 25) -> RequestSender<UserIdentityResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersFollowerOrFollowing = next ?? (followList == .following ? KKEndpoint.Users.following(userIdentity).endpointValue : KKEndpoint.Users.followers(userIdentity).endpointValue)
		let request: APIRequest<UserIdentityResponse, KKAPIError> = tron.codable.request(usersFollowerOrFollowing).buildURL(.relativeToBaseURL)
			.method(.get)
			.parameters([
				"limit": limit
			])
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Follow or unfollow a user with the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user to follow/unfollow.
	///
	/// - Returns: An instance of `RequestSender` with the results of the update follow status response.
	public func updateFollowStatus(forUser userIdentity: UserIdentity) -> RequestSender<FollowUpdateResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersFollow = KKEndpoint.Users.follow(userIdentity).endpointValue
		let request: APIRequest<FollowUpdateResponse, KKAPIError> = tron.codable.request(usersFollow).buildURL(.relativeToBaseURL)
			.method(.post)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Block or unblock a user with the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user to block/unblock.
	///
	/// - Returns: An instance of `RequestSender` with the results of the update block status response.
	public func updateBlockStatus(forUser userIdentity: UserIdentity) -> RequestSender<BlockUpdateResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersBlock = KKEndpoint.Users.block(userIdentity).endpointValue
		let request: APIRequest<BlockUpdateResponse, KKAPIError> = tron.codable.request(usersBlock).buildURL(.relativeToBaseURL)
			.method(.post)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the blocking list for the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose blocking list should be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get block list response.
	public func getBlockList(forUser userIdentity: UserIdentity, next: String? = nil, limit: Int = 25) -> RequestSender<UserIdentityResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersBlocking = next ?? KKEndpoint.Users.blocking(userIdentity).endpointValue
		let request: APIRequest<UserIdentityResponse, KKAPIError> = tron.codable.request(usersBlocking).buildURL(.relativeToBaseURL)
			.method(.get)
			.parameters([
				"limit": limit
			])
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the favorites list for the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose favorites list will be fetched.
	///    - libraryKind: From which library to get the favorites.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get favorites response.
	public func getFavorites(forUser userIdentity: UserIdentity, libraryKind: KKLibrary.Kind, next: String? = nil, limit: Int = 25) -> RequestSender<FavoriteLibraryResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare parameters
		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"limit": limit
		]

		// Prepare request
		let usersFavorites = next ?? KKEndpoint.Users.favorites(userIdentity).endpointValue
		let request: APIRequest<FavoriteLibraryResponse, KKAPIError> = tron.codable.request(usersFavorites).buildURL(.relativeToBaseURL)
			.method(.get)
			.parameters(parameters)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the library entries with the given status in the given user identity library.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose favorites list will be fetched.
	///    - libraryKind: In which library the item should be added.
	///    - libraryStatus: The library status to retrieve the library items for.
	///    - sortType: The sort value by which the retrieved items should be sorted.
	///    - sortOption: The sort option value by which the retrieved items should be sorted.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get library response.
	public func getLibrary(forUser userIdentity: UserIdentity, libraryKind: KKLibrary.Kind, withLibraryStatus libraryStatus: KKLibrary.Status, withSortType sortType: KKLibrary.SortType, withSortOption sortOption: KKLibrary.SortType.Option, next: String? = nil, limit: Int = 25) -> RequestSender<LibraryResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare parameters
		var parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"status": libraryStatus.sectionValue,
			"limit": limit
		]
		if sortType != .none {
			parameters["sort"] = "\(sortType.parameterValue)\(sortOption.parameterValue)"
		}

		// Prepare request
		let usersLibraryIndex = next ?? KKEndpoint.Users.library(userIdentity).endpointValue
		let request: APIRequest<LibraryResponse, KKAPIError> = tron.codable.request(usersLibraryIndex).buildURL(.relativeToBaseURL)
			.method(.get)
			.headers(headers)
			.parameters(parameters)

		// Send request
		return request.sender()
	}

	/// Fetch the reviews list for the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose reviews list will be fetched.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get reviews response.
	public func getReviewsList(forUser userIdentity: UserIdentity, next: String? = nil, limit: Int = 25) -> RequestSender<ReviewResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersReviews = next ?? KKEndpoint.Users.reviews(userIdentity).endpointValue
		let request: APIRequest<ReviewResponse, KKAPIError> = tron.codable.request(usersReviews).buildURL(.relativeToBaseURL)
			.method(.get)
			.parameters([
				"limit": limit
			])
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Fetch the profile details of the given user identity.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose profile details should be fetched.
	///
	/// - Returns: An instance of `RequestSender` with the results of the get user details response.
	public func getDetails(forUser userIdentity: UserIdentity) -> RequestSender<UserResponse, KKAPIError> {
		// Prepare headers
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersProfile = KKEndpoint.Users.profile(userIdentity).endpointValue
		let request: APIRequest<UserResponse, KKAPIError> = tron.codable.request(usersProfile)
			.method(.get)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Search for a user using the given username.
	///
	/// - Parameters:
	///    - username: The username to search for.
	public func searchUsers(for username: String) -> RequestSender<UserIdentityResponse, KKAPIError> {
		// Prepare headers
		var headers = headers
		if !self.authenticationKey.isEmpty {
			headers.add(.authorization(bearerToken: self.authenticationKey))
		}

		// Prepare request
		let usersSearch = KKEndpoint.Users.search(username).endpointValue
		let request: APIRequest<UserIdentityResponse, KKAPIError> = tron.codable.request(usersSearch)
			.method(.get)
			.headers(headers)

		// Send request
		return request.sender()
	}

	/// Deletes the authenticated user's account.
	///
	/// - Parameters:
	///    - password: The authenticated user's password.
	///
	/// - Returns: An instance of `RequestSender` with the results of the delete user response.
	public func deleteUser(password: String) async throws -> KKSuccess {
		// Prepare headers
		var headers = self.headers
		headers.add(.authorization(bearerToken: self.authenticationKey))

		// Prepare parameters
		let parameters = [
			"password": password
		]

		// Prepare request
		let usersDelete = KKEndpoint.Users.delete.endpointValue
		let request: APIRequest<KKSuccess, KKAPIError> = tron.codable.request(usersDelete).buildURL(.relativeToBaseURL)
			.method(.delete)
			.parameters(parameters)
			.headers(headers)

		// Send request
		do {
			let successResponse = try await request.sender().value

			self.authenticationKey = ""
			User.current = nil
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)

			return successResponse
		} catch let error as KKAPIError {
			print("❌ Received delete user error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message)
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			throw error
		} catch {
			print("❌ Received delete user error:", error.localizedDescription)
			throw error
		}
	}
}
