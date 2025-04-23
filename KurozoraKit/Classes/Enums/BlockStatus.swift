//
//  BlockStatus.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 23/04/2025.
//

/// The set of available block status types.
///
/// ```
/// case unblock = -1
/// case disabled = 0
/// case block = 1
/// ```
public enum BlockStatus: Int, Codable, Sendable {
	// MARK: - Cases
	/// Unblock another user.
	case notBlocked = -1

	/// The user can't be blocked or unblocked
	case disabled = 0

	/// Block another user.
	case blocked = 1

	// MARK: - Initializers
	/// Initializes an instance of `BlockStatus` with the given bool value.
	///
	/// If `nil` is given, then an instance of `.disabled` is initialized.
	///
	/// - Parameter bool: The boolean value used to initialize an instance of `BlockStatus`.
	public init(_ bool: Bool?) {
		if let bool = bool {
			self = bool ? .blocked : .notBlocked
		} else {
			self = .disabled
		}
	}
}
