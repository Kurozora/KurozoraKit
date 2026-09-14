//
//  LibrarySyncStream.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/09/2026.
//  MIT License
//

import Foundation

/// The set of cursored delta streams a library sync round carries.
public enum LibrarySyncStream: String, CaseIterable, Sendable {
	// MARK: - Cases
	/// The user's own library rows.
	case entries

	/// The catalog rows of the shows the user tracks.
	case shows

	/// The catalog rows of the literatures the user tracks.
	case literatures

	/// The catalog rows of the games the user tracks.
	case games

	// MARK: - Properties
	/// The library kind whose catalog the stream carries.
	public var kind: LibraryKind? {
		switch self {
		case .entries:
			return nil
		case .shows:
			return .shows
		case .literatures:
			return .literatures
		case .games:
			return .games
		}
	}

	// MARK: - Functions
	/// The stream carrying the given kind's catalog.
	///
	/// - Parameter kind: The library kind.
	///
	/// - Returns: The matching stream.
	public static func trackables(for kind: LibraryKind) -> LibrarySyncStream {
		switch kind {
		case .shows:
			return .shows
		case .literatures:
			return .literatures
		case .games:
			return .games
		}
	}
}
