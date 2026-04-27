//
//  RequestObjectTests.swift
//  KurozoraKitTests
//
//  Created by Khoren Katklian on 14/04/2026.
//  MIT License
//

import XCTest
@testable import KurozoraKit

final class RequestObjectTests: XCTestCase {
	// MARK: - ResourceCollection Decoding
	func testResourceCollectionDecodesWithNext() throws {
		let json = #"{"data":[{"id":"1","type":"shows","href":""}],"next":"https://api.example.test/v1/anime?page=2"}"#
		let collection = try JSONDecoder().decode(ResourceCollection<ShowIdentity>.self, from: Data(json.utf8))

		XCTAssertEqual(collection.data.count, 1)
		XCTAssertEqual(collection.data.first?.id.rawValue, "1")
		XCTAssertNotNil(collection.nextCursor)
		XCTAssertNil(collection.total)
	}

	func testResourceCollectionDecodesWithoutNext() throws {
		let json = #"{"data":[{"id":"2","type":"shows","href":""}]}"#
		let collection = try JSONDecoder().decode(ResourceCollection<ShowIdentity>.self, from: Data(json.utf8))

		XCTAssertEqual(collection.data.count, 1)
		XCTAssertNil(collection.nextCursor)
	}

	func testResourceCollectionDecodesWithTotal() throws {
		let json = #"{"data":[],"next":null,"total":42}"#
		let collection = try JSONDecoder().decode(ResourceCollection<ShowIdentity>.self, from: Data(json.utf8))

		XCTAssertEqual(collection.data.count, 0)
		XCTAssertEqual(collection.total, 42)
	}

	// MARK: - PageCursor
	func testPageCursorEquality() {
		let a = PageCursor(urlString: "https://example.com?page=2")
		let b = PageCursor(urlString: "https://example.com?page=2")
		let c = PageCursor(urlString: "https://example.com?page=3")

		XCTAssertEqual(a, b)
		XCTAssertNotEqual(a, c)
	}

	// MARK: - RequestContext
	func testRequestContextSnapshotsAuthKey() {
		let kurozoraKit = KurozoraKit(apiKey: "key", authenticationKey: "token-A")
		let context = RequestContext(from: kurozoraKit)

		// Mutate the kurozora kit AFTER snapshotting
		kurozoraKit.authenticationKey = "token-B"

		// Context should retain the original token
		XCTAssertEqual(context.headers["Authorization"], "Bearer token-A")
	}

	func testRequestContextOmitsAuthWhenEmpty() {
		let kurozoraKit = KurozoraKit(apiKey: "key", authenticationKey: "")
		let context = RequestContext(from: kurozoraKit)

		XCTAssertNil(context.headers["Authorization"])
	}

	// MARK: - CastIdentity Fetchable
	func testCastIdentityDetailEndpointShowCast() {
		let json = #"{"id":"99","type":"show-cast","href":""}"#
		let cast = try! JSONDecoder().decode(CastIdentity.self, from: Data(json.utf8))
		XCTAssertEqual(cast.detailEndpoint, "show-cast/99")
	}

	func testCastIdentityDetailEndpointLiteratureCast() {
		let json = #"{"id":"88","type":"literature-cast","href":""}"#
		let cast = try! JSONDecoder().decode(CastIdentity.self, from: Data(json.utf8))
		XCTAssertEqual(cast.detailEndpoint, "literature-cast/88")
	}

	func testCastIdentityDetailEndpointGameCast() {
		let json = #"{"id":"77","type":"game-cast","href":""}"#
		let cast = try! JSONDecoder().decode(CastIdentity.self, from: Data(json.utf8))
		XCTAssertEqual(cast.detailEndpoint, "game-cast/77")
	}

	func testCastIdentityDefaultEndpoint() {
		let cast = CastIdentity(id: "50")
		XCTAssertEqual(cast.detailEndpoint, "show-cast/50")
	}

	func testCastIdentityIndexEndpoints() {
		let showCast = try! JSONDecoder().decode(CastIdentity.self, from: Data(#"{"id":"1","type":"show-cast","href":""}"#.utf8))
		let litCast = try! JSONDecoder().decode(CastIdentity.self, from: Data(#"{"id":"2","type":"literature-cast","href":""}"#.utf8))
		let gameCast = try! JSONDecoder().decode(CastIdentity.self, from: Data(#"{"id":"3","type":"game-cast","href":""}"#.utf8))

		XCTAssertEqual(showCast.indexEndpoint, "show-cast")
		XCTAssertEqual(litCast.indexEndpoint, "literature-cast")
		XCTAssertEqual(gameCast.indexEndpoint, "game-cast")
	}

	// MARK: - Fetchable Conformances
	func testShowIdentityFetchableEndpoints() {
		let identity = ShowIdentity(id: "10")
		XCTAssertEqual(identity.detailEndpoint, "anime/10")
		XCTAssertEqual(identity.indexEndpoint, "anime")
	}

	func testGameIdentityFetchableEndpoints() {
		let identity = GameIdentity(id: "20")
		XCTAssertEqual(identity.detailEndpoint, "games/20")
		XCTAssertEqual(identity.indexEndpoint, "games")
	}

	func testLiteratureIdentityFetchableEndpoints() {
		let identity = LiteratureIdentity(id: "30")
		XCTAssertEqual(identity.detailEndpoint, "manga/30")
		XCTAssertEqual(identity.indexEndpoint, "manga")
	}

	func testSeasonIdentityFetchableEndpoints() {
		let identity = SeasonIdentity(id: "40")
		XCTAssertEqual(identity.detailEndpoint, "seasons/40")
		XCTAssertEqual(identity.indexEndpoint, "seasons")
	}

	func testCharacterIdentityFetchableEndpoints() {
		let identity = CharacterIdentity(id: "50")
		XCTAssertEqual(identity.detailEndpoint, "characters/50")
		XCTAssertEqual(identity.indexEndpoint, "characters")
	}

	// MARK: - Relationship Enums
	func testShowRelationshipRawValues() {
		XCTAssertEqual(Show.Relationship.cast.rawValue, "cast")
		XCTAssertEqual(Show.Relationship.relatedShows.rawValue, "relatedShows")
		XCTAssertEqual(Show.Relationship.showSongs.rawValue, "showSongs")
	}

	func testGameRelationshipRawValues() {
		XCTAssertEqual(Game.Relationship.cast.rawValue, "cast")
		XCTAssertEqual(Game.Relationship.relatedGames.rawValue, "relatedGames")
	}
}
