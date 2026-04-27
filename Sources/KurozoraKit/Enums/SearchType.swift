//
//  SearchType.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 22/05/2022.
//  MIT License
//

/// The list of available search types.
///
/// - `characters`: the fetched resource should be of the `characters` type.
/// - `episodes`: the fetched resource should be of the `episodes` type.
/// - `games`: the fetched resource should be of the `games` type.
/// - `literatures`: the fetched resource should be of the `literatures` type.
/// - `people`: the fetched resource should be of the `people` type.
/// - `shows`: the fetched resource should be of the `shows` type.
/// - `songs`: the fetched resource should be of the `songs` type.
/// - `studios`: the fetched resource should be of the `studios` type.
/// - `users`: the fetched resource should be of the `users` type.
///
/// - Tag: SearchType
public enum SearchType: String, Sendable {
	/// Indicates the fetched resource should be of the `characters` type.
	///
	/// - Tag: SearchType-characters
	case characters

	/// Indicates the fetched resource should be of the `episodes` type.
	///
	/// - Tag: SearchType-episodes
	case episodes

	/// Indicates the fetched resource should be of the `games` type.
	///
	/// - Tag: SearchType-games
	case games

	/// Indicates the fetched resource should be of the `literatures` type.
	///
	/// - Tag: SearchType-literatures
	case literatures

	/// Indicates the fetched resource should be of the `people` type.
	///
	/// - Tag: SearchType-people
	case people

	/// Indicates the fetched resource should be of the `shows` type.
	///
	/// - Tag: SearchType-shows
	case shows

	/// Indicates the fetched resource should be of the `songs` type.
	///
	/// - Tag: SearchType-songs
	case songs

	/// Indicates the fetched resource should be of the `studios` type.
	///
	/// - Tag: SearchType-studios
	case studios

	/// Indicates the fetched resource should be of the `users` type.
	///
	/// - Tag: SearchType-users
	case users
}
