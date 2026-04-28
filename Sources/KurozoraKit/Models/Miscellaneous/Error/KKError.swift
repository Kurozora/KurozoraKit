//
//  KKError.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/12/2018.
//  MIT License
//

import Foundation

/// A description of an error returned by the Kurozora service.
///
/// Errors surfaced through ``APIError`` may carry one or more `KKError`
/// values describing what went wrong. Inspect ``id`` to branch on a specific
/// failure mode, or display ``title`` and ``detail`` directly to the user.
public struct KKError: Codable, Sendable {
	// MARK: - Properties
	/// A unique identifier for this occurrence of the error.
	public let id: Int

	/// The [HTTP status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) associated with the error.
	public let status: Int

	/// A human-readable explanation specific to this occurrence of the error.
	public let detail: String

	/// A short, human-readable summary of the error.
	public let title: String
}
