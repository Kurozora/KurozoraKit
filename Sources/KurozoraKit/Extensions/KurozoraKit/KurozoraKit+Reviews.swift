//
//  KurozoraKit+Reviews.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 09/04/2025.
//  MIT License
//

import Foundation

extension KurozoraKit {
	/// Deletes the specified review.
	///
	/// - Parameter reviewIdentity: The identity of the review to delete.
	///
	/// - Returns: A ``KKSuccess`` indicating whether the deletion succeeded.
	public func delete(_ reviewIdentity: ReviewIdentity) async throws -> KKSuccess {
		var headers = self.headers
		headers["Authorization"] = "Bearer \(self.authenticationKey)"

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.Reviews.delete(reviewIdentity).endpointValue,
			method: .delete,
			headers: headers
		)
		return try await self.client.send(request)
	}
}
