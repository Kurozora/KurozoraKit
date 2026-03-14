//
//  KKAPIError.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/08/2020.
//  MIT License
//

import Foundation

/// An immutable object that stores information about a single failed request, such as the error message.
public final class KKAPIError: Error, @unchecked Sendable {
	// MARK: - Properties
	/// The HTTP response returned by the server, if any.
	public let response: HTTPURLResponse?

	/// Server-side error payload, decoded from the response body when available.
	public let errors: [KKError]

	/// The underlying error, if the failure originated outside the server.
	public let underlying: Error?

	/// The originating `URLRequest`, if any.
	public let request: URLRequest?

	/// Override message, set for specific status codes where a friendlier
	/// user-facing message is preferred over the raw server detail.
	private let overrideMessage: String?

	// MARK: - Initializers
	/// Creates an error from a non-2xx server response.
	internal init(responseData data: Data, response: HTTPURLResponse, request: URLRequest?, decoder: JSONDecoder) {
		self.response = response
		self.request = request
		self.underlying = nil

		let decoded = (try? decoder.decode(KKErrorResponse.self, from: data))?.errors ?? []
		self.errors = decoded

		switch response.statusCode {
		case 500:
			self.overrideMessage = "There was an error while connecting to the server. If this error persists, check out our Twitter account @KurozoraApp for more information!"
		default:
			self.overrideMessage = nil
		}
	}

	/// Creates an error from a transport failure.
	internal init(transport error: Error, request: URLRequest?) {
		self.response = nil
		self.errors = []
		self.underlying = error
		self.request = request
		self.overrideMessage = nil
	}

	/// Creates an error from a response-decoding failure.
	internal init(decoding error: Error, response: HTTPURLResponse?, request: URLRequest?) {
		self.response = response
		self.errors = []
		self.underlying = error
		self.request = request
		self.overrideMessage = nil
	}

	/// Creates an error with a hand-crafted message.
	internal init(message: String, response: HTTPURLResponse?, request: URLRequest?) {
		self.response = response
		self.errors = []
		self.underlying = nil
		self.request = request
		self.overrideMessage = message
	}
}

// MARK: - Helpers
public extension KKAPIError {
	/// The HTTP status code of the failed response, if any.
	var statusCode: Int? {
		return self.response?.statusCode
	}

	/// The message of a failed request.
	var message: String {
		if let overrideMessage = self.overrideMessage {
			return overrideMessage
		}

		if let first = self.errors.first {
			return first.detail
		}

		if let underlying = self.underlying {
			return underlying.localizedDescription
		}

		return "An unknown error occurred."
	}
}
