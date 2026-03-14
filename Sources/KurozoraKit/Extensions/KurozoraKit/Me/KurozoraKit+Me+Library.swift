//
//  KurozoraKit+Library.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/08/2020.
//  MIT License
//

import Foundation

public extension KurozoraKit {
	/// Fetches the authenticated user's library entries with the specified filters.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library to query.
	///    - libraryStatus: The library status to filter by.
	///    - sortType: The sort type to apply to results.
	///    - sortOption: The sort direction to apply.
	///    - next: The URL string of the next page in the paginated response. Use `nil` to get first page.
	///    - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned. The default value is 25 and the maximum value is 100.
	///
	/// - Returns: A ``LibraryResponse`` containing the matching library entries.
	func getLibrary(_ libraryKind: KKLibrary.Kind, withLibraryStatus libraryStatus: KKLibrary.Status, withSortType sortType: KKLibrary.SortType, withSortOption sortOption: KKLibrary.SortType.Option, next: String? = nil, limit: Int = 25) async throws -> LibraryResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"status": libraryStatus.sectionValue,
			"limit": limit,
		]
		if sortType != .none {
			parameters["sort"] = "\(sortType.parameterValue)\(sortOption.parameterValue)"
		}

		let request = KKRequest<LibraryResponse>(
			path: next ?? KKEndpoint.Me.Library.index.endpointValue,
			method: .get,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Adds an item to the authenticated user's library with the given status.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library to add the item to.
	///    - libraryStatus: The initial status for the library entry.
	///    - modelID: The identifier of the item to add.
	///
	/// - Returns: A ``LibraryUpdateResponse`` containing the updated library state.
	func addToLibrary(_ libraryKind: KKLibrary.Kind, withLibraryStatus libraryStatus: KKLibrary.Status, modelID: KurozoraItemID) async throws -> LibraryUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"model_id": modelID,
			"status": libraryStatus.rawValue,
		]

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.index.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Updates a library entry for the authenticated user.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library containing the item.
	///    - modelID: The identifier of the item to update.
	///    - rewatchCount: An optional new rewatch count for the entry.
	///    - isHidden: An optional flag to show or hide the entry.
	///
	/// - Returns: A ``LibraryUpdateResponse`` containing the updated library state.
	func updateInLibrary(_ libraryKind: KKLibrary.Kind, modelID: KurozoraItemID, rewatchCount: Int?, isHidden: Bool?) async throws -> LibraryUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		var parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"model_id": modelID,
		]
		if let rewatchCount = rewatchCount {
			parameters["rewatch_count"] = rewatchCount
		}
		if let isHidden = isHidden {
			parameters["is_hidden"] = isHidden
		}

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.update.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Removes an item from the authenticated user's library.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library to remove from.
	///    - modelID: The identifier of the item to remove.
	///
	/// - Returns: A ``LibraryUpdateResponse`` containing the updated library state.
	func removeFromLibrary(_ libraryKind: KKLibrary.Kind, modelID: KurozoraItemID) async throws -> LibraryUpdateResponse {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"model_id": modelID,
		]

		let request = KKRequest<LibraryUpdateResponse>(
			path: KKEndpoint.Me.Library.delete.endpointValue,
			method: .post,
			headers: headers,
			body: .formURLEncoded(parameters)
		)
		return try await self.client.send(request)
	}

	/// Clears all items from the authenticated user's library.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library to clear.
	///    - password: The user's password for verification.
	///
	/// - Returns: A ``KKSuccess`` indicating the library was cleared.
	func clearLibrary(_ libraryKind: KKLibrary.Kind, password: String) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"password": password,
		]

		// DELETE with parameters → query string.
		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Library.clear.endpointValue,
			method: .delete,
			headers: headers,
			query: parameters
		)
		return try await self.client.send(request)
	}

	/// Imports a library file into the authenticated user's library.
	///
	/// - Parameters:
	///    - libraryKind: The kind of library to import into.
	///    - service: The service the import file originated from.
	///    - behavior: The import behavior to use when resolving conflicts.
	///    - filePath: The URL of the file to import.
	///
	/// - Returns: A ``KKSuccess`` indicating the import was started.
	func importToLibrary(_ libraryKind: KKLibrary.Kind, importService service: LibraryImport.Service, importBehavior behavior: LibraryImport.Behavior, filePath: URL) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let parameters: [String: Any] = [
			"library": libraryKind.rawValue,
			"service": service.rawValue,
			"behavior": behavior.rawValue,
		]

		var formData = KKMultipartFormData()
		try formData.append(filePath, withName: "file", fileName: "LibraryImport.xml", mimeType: "text/xml")

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Me.Library.import.endpointValue,
			method: .post,
			headers: headers,
			body: .multipart(formData, parameters: parameters)
		)
		return try await self.client.send(request)
	}
}
