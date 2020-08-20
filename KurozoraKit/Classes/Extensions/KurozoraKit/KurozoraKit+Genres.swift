//
//  KurozoraKit+Genre.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/09/2019.
//  Copyright © 2019 Kurozora. All rights reserved.
//

import TRON
import SCLAlertView

extension KurozoraKit {
	/**
		Fetch the list of genres.

		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getGenres(completion completionHandler: @escaping (_ result: Result<[Genre], KKAPIError>) -> Void) {
		let genresIndex = KKEndpoint.Shows.Genres.index.endpointValue
		let request: APIRequest<GenreResponse, KKAPIError> = tron.codable.request(genresIndex)
		request.headers = headers
		request.method = .get
		request.perform(withSuccess: { genreResponse in
			completionHandler(.success(genreResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get genres list 😔", subTitle: error.message)
			}
			print("❌ Received get genres error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Fetch the genre details for the given genre id.

		- Parameter genreID: The id of the genre for which the details should be fetched.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getDetails(forGenreID genreID: Int, completion completionHandler: @escaping (_ result: Result<[Genre], KKAPIError>) -> Void) {
		let genresDetails = KKEndpoint.Shows.Genres.details(genreID).endpointValue
		let request: APIRequest<GenreResponse, KKAPIError> = tron.codable.request(genresDetails)
		request.headers = headers
		request.method = .get
		request.perform(withSuccess: { genreResponse in
			completionHandler(.success(genreResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get genre details 😔", subTitle: error.message)
			}
			print("❌ Received get genre details error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}
}