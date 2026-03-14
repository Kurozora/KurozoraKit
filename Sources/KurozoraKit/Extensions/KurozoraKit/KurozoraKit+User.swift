//
//  KurozoraKit+Users.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  MIT License
//

import Foundation
#if !os(watchOS)
import UIKit
#endif

public extension KurozoraKit {
	#if !os(watchOS)
	/// Creates a new user account with the given credentials.
	///
	/// - Parameters:
	///    - username: The desired username for the new account.
	///    - emailAddress: The email address to associate with the account.
	///    - password: The password for the new account.
	///    - profileImage: An optional profile image to upload during registration.
	///
	/// - Returns: A ``KKSuccess`` indicating the account was created.
	func signUp(withUsername username: String, emailAddress: String, password: String, profileImage: UIImage?) async throws -> KKSuccess {
		let headers = self.headers

		let parameters: [String: Any] = [
			"username": username,
			"email": emailAddress,
			"password": password,
		]

		var formData = KKMultipartFormData()
		if let profileImageData = profileImage?.jpegData(compressionQuality: 0.1) {
			formData.append(profileImageData, withName: "profileImage", fileName: "ProfileImage.png", mimeType: "image/png")
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.signUp.endpointValue,
			method: .post,
			headers: headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.client.send(request)
	}
	#endif

	#if !os(watchOS)
	/// Signs in a user with the given email and password.
	///
	/// - Parameters:
	///    - email: The user's email address.
	///    - password: The user's password.
	///
	/// - Returns: A ``SignInResponse`` containing the authentication token and user data.
	func signIn(_ email: String, _ password: String) async throws -> SignInResponse {
		let parameters: [String: Any] = await [
			"email": email,
			"password": password,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName,
		]

		let request = KKRequest<SignInResponse>(
			path: KKEndpoint.Users.signIn.endpointValue,
			method: .post,
			headers: self.headers,
			body: .formURLEncoded(parameters)
		)

		do {
			let signInResponse = try await self.client.send(request)
			self.authenticationKey = signInResponse.authenticationToken
			User.current = signInResponse.data.first
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
			return signInResponse
		} catch let error as KKAPIError {
			print("❌ Received sign in error — server message:", error.message)
			throw error
		} catch {
			print("❌ Received sign in error:", error.localizedDescription)
			throw error
		}
	}

	/// Signs in or registers an account using Sign in with Apple.
	///
	/// - Parameter token: A JSON Web Token (JWT) provided by Sign in with Apple.
	///
	/// - Returns: An ``OAuthResponse`` containing the authentication result and user data.
	func signIn(withAppleID token: String) async throws -> OAuthResponse {
		let parameters: [String: Any] = await [
			"token": token,
			"platform": UIDevice.commonSystemName,
			"platform_version": UIDevice.current.systemVersion,
			"device_vendor": "Apple",
			"device_model": UIDevice.modelName,
		]

		let request = KKRequest<OAuthResponse>(
			path: KKEndpoint.Users.siwaSignIn.endpointValue,
			method: .post,
			headers: self.headers,
			body: .formURLEncoded(parameters)
		)

		do {
			let oAuthResponse = try await self.client.send(request)
			self.authenticationKey = oAuthResponse.authenticationToken
			User.current = oAuthResponse.data?.first
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
			return oAuthResponse
		} catch let error as KKAPIError {
			print("❌ Received sign in with SIWA error — server message:", error.message)
			throw error
		} catch {
			print("❌ Received sign in with SIWA error:", error.localizedDescription)
			throw error
		}
	}
	#endif

	/// Sends a password reset link to the given email address.
	///
	/// - Parameter emailAddress: The email address to send the reset link to.
	///
	/// - Returns: A ``KKSuccess`` indicating the reset email was sent.
	func resetPassword(withEmailAddress emailAddress: String) async throws -> KKSuccess {
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.resetPassword.endpointValue,
			method: .post,
			headers: self.headers,
			body: .formURLEncoded(["email": emailAddress])
		)
		return try await self.client.send(request)
	}

	/// Fetches the followers or following list for the given user.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose list to fetch.
	///    - followList: The type of list to retrieve (followers or following).
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``UserIdentityResponse`` containing the requested user identities.
	func getFollowList(forUser userIdentity: UserIdentity, _ followList: UsersListType, next: String? = nil, limit: Int = 25) async throws -> UserIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let path = next ?? (followList == .following ? KKEndpoint.Users.following(userIdentity).endpointValue : KKEndpoint.Users.followers(userIdentity).endpointValue)
		let request = KKRequest<UserIdentityResponse>(
			path: path,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Toggles the follow status for the given user.
	///
	/// - Parameter userIdentity: The identity of the user to follow or unfollow.
	///
	/// - Returns: A ``FollowUpdateResponse`` containing the updated follow status.
	func updateFollowStatus(forUser userIdentity: UserIdentity) async throws -> FollowUpdateResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<FollowUpdateResponse>(
			path: KKEndpoint.Users.follow(userIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Toggles the block status for the given user.
	///
	/// - Parameter userIdentity: The identity of the user to block or unblock.
	///
	/// - Returns: A ``BlockUpdateResponse`` containing the updated block status.
	func updateBlockStatus(forUser userIdentity: UserIdentity) async throws -> BlockUpdateResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<BlockUpdateResponse>(
			path: KKEndpoint.Users.block(userIdentity).endpointValue,
			method: .post,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Fetches the list of blocked users for the given user.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose block list to fetch.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``UserIdentityResponse`` containing the blocked user identities.
	func getBlockList(forUser userIdentity: UserIdentity, next: String? = nil, limit: Int = 25) async throws -> UserIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<UserIdentityResponse>(
			path: next ?? KKEndpoint.Users.blocking(userIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the favorites for the given user filtered by library kind.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose favorites to fetch.
	///    - libraryKind: The kind of library to filter favorites by.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``FavoriteLibraryResponse`` containing the user's favorited items.
	func getFavorites(forUser userIdentity: UserIdentity, libraryKind: KKLibrary.Kind, next: String? = nil, limit: Int = 25) async throws -> FavoriteLibraryResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"limit": limit,
		]

		let request = KKRequest<FavoriteLibraryResponse>(
			path: next ?? KKEndpoint.Users.favorites(userIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches library entries for the given user with the specified filters.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose library to fetch.
	///    - libraryKind: The kind of library to query.
	///    - libraryStatus: The library status to filter by.
	///    - sortType: The sort type to apply to results.
	///    - sortOption: The sort direction to apply.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LibraryResponse`` containing the matching library entries.
	func getLibrary(forUser userIdentity: UserIdentity, libraryKind: KKLibrary.Kind, withLibraryStatus libraryStatus: KKLibrary.Status, withSortType sortType: KKLibrary.SortType, withSortOption sortOption: KKLibrary.SortType.Option, next: String? = nil, limit: Int = 25) async throws -> LibraryResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		var parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"status": libraryStatus.sectionValue,
			"limit": limit,
		]
		if sortType != .none {
			parameters["sort"] = "\(sortType.parameterValue)\(sortOption.parameterValue)"
		}

		let request = KKRequest<LibraryResponse>(
			path: next ?? KKEndpoint.Users.library(userIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Fetches the reviews written by the given user.
	///
	/// - Parameters:
	///    - userIdentity: The identity of the user whose reviews to fetch.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``ReviewResponse`` containing the user's reviews.
	func getReviewsList(forUser userIdentity: UserIdentity, next: String? = nil, limit: Int = 25) async throws -> ReviewResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<ReviewResponse>(
			path: next ?? KKEndpoint.Users.reviews(userIdentity).endpointValue,
			method: .get,
			headers: headers,
			query: ["limit": limit]
		)
		return try await self.client.send(request)
	}

	/// Fetches the profile details for the given user.
	///
	/// - Parameter userIdentity: The identity of the user to retrieve.
	///
	/// - Returns: A ``UserResponse`` containing the user's profile data.
	func getDetails(forUser userIdentity: UserIdentity) async throws -> UserResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<UserResponse>(
			path: KKEndpoint.Users.profile(userIdentity).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Searches for users matching the given username.
	///
	/// - Parameter username: The username to search for.
	///
	/// - Returns: A ``UserIdentityResponse`` containing the matching user identities.
	func searchUsers(for username: String) async throws -> UserIdentityResponse {
		var headers = self.headers
		if !self.authenticationKey.isEmpty {
			headers["Authorization"] = "Bearer \(self.authenticationKey)"
		}

		let request = KKRequest<UserIdentityResponse>(
			path: KKEndpoint.Users.search(username).endpointValue,
			method: .get,
			headers: headers
		)
		return try await self.client.send(request)
	}

	/// Deletes the authenticated user's account.
	///
	/// - Parameter password: The user's password for verification.
	///
	/// - Returns: A ``KKSuccess`` indicating the account was deleted.
	func deleteUser(password: String) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Users.delete.endpointValue,
			method: .delete,
			headers: headers,
			query: ["password": password]
		)

		do {
			let successResponse = try await self.client.send(request)
			self.authenticationKey = ""
			User.current = nil
			NotificationCenter.default.post(name: .KUserIsSignedInDidChange, object: nil)
			return successResponse
		} catch let error as KKAPIError {
			print("❌ Received delete user error — server message:", error.message)
			throw error
		} catch {
			print("❌ Received delete user error:", error.localizedDescription)
			throw error
		}
	}
}
