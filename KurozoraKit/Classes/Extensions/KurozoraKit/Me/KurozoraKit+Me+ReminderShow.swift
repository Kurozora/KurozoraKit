//
//  KurozoraKit+ReminderShow.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//

import TRON
import SCLAlertView

extension KurozoraKit {
	/**
		Fetch the list of reminder shows for the authenticated user.

		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func getReminderShows(completion completionHandler: @escaping (_ result: Result<[Show], KKAPIError>) -> Void) {
		let meReminderShowIndex = KKEndpoint.Me.ReminderShow.index.endpointValue
		let request: APIRequest<ShowResponse, KKAPIError> = tron.codable.request(meReminderShowIndex)

		request.headers = headers
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .get
		request.perform(withSuccess: { showResponse in
			completionHandler(.success(showResponse.data))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't get reminders 😔", subTitle: error.message)
			}
			print("❌ Received get reminder show error:", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Update the `ReminderStatus` value of a show in the authenticated user's library.

		- Parameter showID: The id of the show whose reminder status should be updated.
		- Parameter completionHandler: A closure returning a value that represents either a success or a failure, including an associated value in each case.
		- Parameter result: A value that represents either a success or a failure, including an associated value in each case.
	*/
	public func updateReminderStatus(forShow showID: Int, completion completionHandler: @escaping (_ result: Result<ReminderStatus, KKAPIError>) -> Void) {
		let meReminderShowUpdate = KKEndpoint.Me.ReminderShow.update.endpointValue
		let request: APIRequest<ReminderShowResponse, KKAPIError> = tron.codable.request(meReminderShowUpdate)

		request.headers = headers
		request.headers["kuro-auth"] = self.authenticationKey

		request.method = .post
		request.parameters = [
			"anime_id": showID,
		]
		request.perform(withSuccess: { reminderShowResponse in
			completionHandler(.success(reminderShowResponse.data.reminderStatus))
		}, failure: { [weak self] error in
			guard let self = self else { return }
			if self.services.showAlerts {
				SCLAlertView().showError("Can't update reminder status 😔", subTitle: error.message)
			}
			print("❌ Received update reminder status error", error.errorDescription ?? "Unknown error")
			print("┌ Server message:", error.message ?? "No message")
			print("├ Recovery suggestion:", error.recoverySuggestion ?? "No suggestion available")
			print("└ Failure reason:", error.failureReason ?? "No reason available")
			completionHandler(.failure(error))
		})
	}

	/**
		Prompt the authenticated user to subscribe to their reminders.
	*/
	public func subscribeToReminder() {
		let meReminderShowDownload = KKEndpoint.Me.ReminderShow.download.endpointValue
		let subscriptionURL = tron.urlBuilder.url(forPath: meReminderShowDownload)
		UIApplication.shared.open(subscriptionURL, options: [:], completionHandler: nil)
	}
}
