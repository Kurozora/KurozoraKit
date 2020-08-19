//
//  KurozoraKit+FavoriteShow.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//

import TRON
import SCLAlertView

extension KurozoraKit {
	/**
		Fetch the favorite shows list for the authenticated user.

		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getFavoriteShows(completion completionHandler: @escaping (_ result: Result<[Show], KKAPIError>) -> Void) {
		let meFavoriteShowIndex = KKEndpoint.Me.FavoriteShow.index.endpointValue
		let request: APIRequest<ShowResponse, KKAPIError> = tron.codable.request(meFavoriteShowIndex)

		request.headers = headers
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .get
		request.perform(withSuccess: { showResponse in
			completionHandler(.success(showResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get favorites list 😔", subTitle: error.message)
			}
			print("❌ Received get favorites error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Update the `FavoriteStatus` value of a show in the authenticated user's library.

		- Parameter showID: The id of the show whose favorite status should be updated.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func updateFavoriteShowStatus(_ showID: Int, completion completionHandler: @escaping (_ result: Result<FavoriteStatus, KKAPIError>) -> Void) {
		let meFavoriteShowUpdate = KKEndpoint.Me.FavoriteShow.update.endpointValue
		let request: APIRequest<FavoriteShowResponse, KKAPIError> = tron.codable.request(meFavoriteShowUpdate)

		request.headers = headers
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .post
		request.parameters = [
			"anime_id": showID,
		]
		request.perform(withSuccess: { favoriteShowResponse in
			completionHandler(.success(favoriteShowResponse.data.favoriteStatus))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't update favorite status 😔", subTitle: error.message)
			}
			print("❌ Received update favorite status error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}
}
