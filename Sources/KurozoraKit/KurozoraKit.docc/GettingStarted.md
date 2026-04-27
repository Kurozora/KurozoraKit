# Getting Started with Kurozora

KurozoraKit provides seamless access to the Kurozora API, allowing you to interact with anime, manga, games, music, and more. This guide will walk you through initializing KurozoraKit, setting up custom services, and making API requests.

## Overview

KurozoraKit simplifies API integration by offering a modular and configurable approach. With KurozoraKit, you can:

- Initialize the client with custom API endpoints.
- Use additional services like secure storage via Keychain.
- Make asynchronous API requests to fetch data with Swift concurrency.

## Initialize

KurozoraKit can be implemented using one line in the `global` scope.

```swift
let kurozoraKit = KurozoraKit()
```

KurozoraKit allows you to set your own API endpoint. For example, if you have a custom API endpoint for debugging purposes, you can set it like this:

```swift
let kurozoraKit = KurozoraKit(apiEndpoint: .custom("https://kurozora.debug/api/"))
```

KurozoraKit also accepts a `KKServices` object to enable and manage extra functionality. For example to manage Keychain data you can do something like the following:

```swift
// Prepare Keychain with your desired setting.
let appIdentifierPrefix = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as! String
let keychain = Keychain(service: app_name, accessGroup: "\(appIdentifierPrefix)com.company.shared")
	.synchronizable(true)
	.accessibility(.afterFirstUnlock)

// Pass the keychain object.
let services = KKServices(keychain: keychain)

// Pass KKService
let kurozoraKit = KurozoraKit(authenticationKey: bearer_token).services(services)
```

You can also chain desired methods instead of passing data as a parameter.

```swift
let services = KKServices().keychainDefaults(keychain)
let kurozoraKit = KurozoraKit()
	.authenticationKey(bearer_token)
	.services(services)
```

## Making API Requests

Once KurozoraKit is initialized, you can start making API requests. Every endpoint returns a request object that you configure with builder methods and execute by calling `response()`.

### Retrieve a Show

To retrieve the details for a show, including its cast and seasons:

```swift
let showIdentity = ShowIdentity(id: "1234")

do {
	let showResponse = try await kurozoraKit
		.detail(showIdentity, including: [.cast, .seasons])
		.response()
	print(showResponse.data)
} catch {
	print("Failed to fetch show: \(error)")
}
```

### Browse the Catalog

To retrieve a paginated list of shows:

```swift
do {
	let page1 = try await kurozoraKit.shows().limit(25).response()
	print(page1.data)

	// Fetch the next page using the cursor.
	if let cursor = page1.nextCursor {
		let page2 = try await kurozoraKit.shows().cursor(cursor).response()
		print(page2.data)
	}
} catch {
	print("Failed to fetch shows: \(error)")
}
```

### Search for Content

KurozoraKit provides a search API to find anime, manga, games, and more based on keywords:

```swift
let query = "Re:Zero"

do {
	let searchResponse = try await kurozoraKit
		.search(.kurozora, types: [.shows], query: query)
		.limit(10)
		.response()
	print(searchResponse.data)
} catch {
	print("Search failed: \(error)")
}
```

### Manage Your Library

To fetch and update your library:

```swift
do {
	// Fetch the library.
	let library = try await kurozoraKit
		.library(.shows, status: .inProgress)
		.sorted(by: .alphabetically, .ascending)
		.response()
	print(library.data)

	// Add a show to the library.
	_ = try await kurozoraKit
		.addToLibrary(.shows, status: .planning, itemID: showIdentity.id)
		.response()
} catch {
	print("Library operation failed: \(error)")
}
```
