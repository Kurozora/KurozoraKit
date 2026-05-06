//
//  ReportParentalGuideEntryRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 05/05/2026.
//  MIT License
//

import Foundation

/// A request that files a report against a parental guide entry.
public struct ReportParentalGuideEntryRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext
	private let entryIdentity: ParentalGuideEntryIdentity
	private let reason: ParentalGuideReportReason
	private let details: String?

	// MARK: - Initializers
	internal init(context: RequestContext, entryIdentity: ParentalGuideEntryIdentity, reason: ParentalGuideReportReason, details: String?) {
		self.context = context
		self.entryIdentity = entryIdentity
		self.reason = reason
		self.details = details
	}

	// MARK: - Execution
	/// Executes the request and returns the decoded response.
	public func response() async throws -> KKSuccess {
		var body: [String: Any] = ["reason_key": self.reason.rawValue]

		if let details = self.details, !details.isEmpty {
			body["details"] = details
		}

		let request = KKRequest<KKSuccess>(
			path: KKEndpoint.ParentalGuide.reportEntry(self.entryIdentity).endpointValue,
			method: .post,
			headers: self.context.headers,
			body: .formURLEncoded(body)
		)

		return try await self.context.client.send(request)
	}
}
