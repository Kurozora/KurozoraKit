//
//  WatchedOverlay.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 12/07/2026.
//  MIT License
//

import Foundation

/// A root object that stores the response to a watched overlay batch request.
public struct WatchedOverlayResponse: Codable, Sendable {
	// MARK: - Properties
	/// The watched-state resources returned by the server.
	public let data: [WatchedOverlayEntry]
}

/// A single watched-state resource for one episode.
public struct WatchedOverlayEntry: Codable, Sendable {
	// MARK: - Properties
	/// The watched-state attributes for this episode.
	public let attributes: WatchedOverlayAttributes

	/// The relationships of this watched-state resource — at minimum the episode it points at, as an identity reference.
	public let relationships: WatchedOverlayRelationships
}

/// The attributes of a watched-state resource.
public struct WatchedOverlayAttributes: Codable, Sendable {
	// MARK: - Properties
	/// The number of times the user has rewatched the episode.
	public let rewatchCount: Int

	/// The timestamp at which the user first watched the episode, in seconds
	/// since the Unix epoch.
	public let watchedAt: Int?
}

/// The relationships of a watched-state resource.
public struct WatchedOverlayRelationships: Codable, Sendable {
	// MARK: - Properties
	/// The episode this watched-state resource points at, as an identity reference.
	public let episodes: WatchedOverlayEpisodeIdentities
}

/// The wrapper for an `episodes` relationship containing identity references.
public struct WatchedOverlayEpisodeIdentities: Codable, Sendable {
	// MARK: - Properties
	/// The identity references for the episodes — typically a single-element array.
	public let data: [EpisodeIdentity]
}
