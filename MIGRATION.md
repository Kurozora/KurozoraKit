
# Migrating to KurozoraKit 2.1

KurozoraKit 2.1 adds two-factor authentication enforcement to the sign-in flow. Email/password sign-in now has two possible successful outcomes:

1. the existing token-issuing path
2. a 2FA challenge path that must be completed before a session is granted

## Breaking change: `SignInRequest.response()` return type

```swift
// Before (2.0)
let response: SignInResponse = try await KService.signIn(email: email, password: password).response()
// `User.current` is set, app navigates to the signed-in state.

// After (2.1)
let result: SignInResult = try await KService.signIn(email: email, password: password).response()
switch result {
case .signedIn(let response):
    // Same behavior as 2.0: session is recorded, `User.current` is set.
case .requiresTwoFactor(let challengeToken):
    // Account requires 2FA: present a code-entry UI and call:
    let response = try await KService
        .submitTwoFactorChallenge(token: challengeToken)
        .otp("123456") // or .recoveryCode("abcde12345-fghij67890")
        .response()
    // Now `User.current` is set, navigate to the signed-in state.
}
```

`SignInResponse` itself is unchanged. It is now wrapped in `SignInResult.signedIn(_:)` for the no-2FA path, and returned directly from `TwoFactorChallengeRequest.response()` after a successful redemption.

## New: `submitTwoFactorChallenge(token:)`

Resolves a challenge token issued by step 1. Configure with exactly one of:

- `.otp("123456")`: 6-digit TOTP code from the user's authenticator app.
- `.recoveryCode("abcde12345-fghij67890")`: single-use recovery code from enrollment.

Calling `response()` without a credential, or with both, throws an `APIError` synchronously.

## New: a capability flag is sent automatically

`SignInRequest` now sends `client_supports_2fa=1` on every sign-in attempt. No consumer action is required. Older clients without this flag are blocked server-side with a 403 + `KKError.id == 40003` when the account has 2FA enabled.

Sign in with Apple is unchanged. Apple enforces 2FA at the OS level, so `signIn(withAppleIDToken:)` continues to return a token directly.

# Migrating to KurozoraKit 2.0

KurozoraKit 2.0 is a breaking release that drops `TRON` and `Alamofire` for `URLSession`, and replaces the free-method API with typed request objects. There are is no backwards compatibility, so every call site must be updated.

## Overview

- Networking is rebuilt on `URLSession`. `TRON` and `Alamofire` are no longer dependencies.
- Each endpoint is now a `Sendable` request object with a builder API and an `async throws` `response()` method.
- Pagination uses opaque ``PageCursor`` tokens.
- Relationships use typed enums on each model.
- Most paginated responses are unified under generic ``ResourceCollection``.
- Several types lose their `KK` prefix.

## Package

```swift
.package(url: "https://github.com/Kurozora/KurozoraKit.git", from: "2.0.0"),
```

If your app reached `Alamofire` or `TRON` through KurozoraKit, add them as direct dependencies of your own package.

## Configuration

The plugin list on ``KurozoraAPI/custom(_:_:)`` is replaced by ``KurozoraAPIOptions``.

```swift
// Before
let api = KurozoraAPI.custom("https://staging.kurozora.app/v1/", [NetworkLoggerPlugin()])

// After
let api = KurozoraAPI.custom(
    "https://staging.kurozora.app/v1/",
    KurozoraAPIOptions(logLevel: .debug)
)
```

`KurozoraAPIOptions` exposes `logLevel`, `timeout`, and `additionalHeaders`. Network logs are emitted through `os.Logger` with subsystem `app.kurozora.KurozoraKit` and category `Networking`.

## Errors

``APIError`` (formerly `KKAPIError`) no longer inherits from `TRON.APIError`. The pattern-matchable surface is:

```swift
public final class APIError: Error {
    public let response: HTTPURLResponse?
    public let errors: [KKError]
    public let underlying: Error?
    public let request: URLRequest?
    public var statusCode: Int? { response?.statusCode }
    public var message: String { ... }
}
```

Replace `errorDescription`, `recoverySuggestion`, and `failureReason` with `message` (user-facing copy) or `underlying?.localizedDescription` (raw cause).

## Request objects

Endpoints are factory methods on ``KurozoraKit`` that return a request object. Configure with builder methods, then call ``response()``.

### Detail and batch detail

```swift
// Before
let response = try await KService.getDetails(forShow: identity, including: ["cast", "seasons"])
let response: ShowResponse = try await KService.getDetails(for: identitiesToFetch)

// After
let response = try await KService.detail(identity, including: [.cast, .seasons]).response()
let response = try await KService.details(identitiesToFetch).response()
```

### Paginated lists

`next: String?` is replaced by an opaque ``PageCursor``.

```swift
// Before
let page1 = try await KService.showsIndex(next: nil, limit: 25, filter: filter)
let page2 = try await KService.showsIndex(next: page1.next, limit: 25, filter: filter)

// After
let page1 = try await KService.shows().limit(25).filter(filter).response()
let page2 = try await KService.shows().cursor(page1.nextCursor).limit(25).response()
```

### Relationships

Per-resource enums replace `including: [String]`, and sub-resources are first-class request methods.

```swift
try await KService.detail(showIdentity, including: [.cast, .seasons]).response()
try await KService.cast(for: showIdentity).limit(50).response()
try await KService.studios(for: showIdentity).response()
```

### Search and library

```swift
try await KService.search(.kurozora, types: [.shows], query: "AOT").limit(10).response()

try await KService.library(.shows, status: .inProgress)
    .sorted(by: .alphabetically, .ascending)
    .response()

try await KService.addToLibrary(.shows, status: .watching, itemID: show.id).response()
try await KService.updateInLibrary(.shows, itemID: show.id).rewatchCount(3).response()
try await KService.removeFromLibrary(.shows, itemID: show.id).response()
```

### Authentication

``signIn(email:password:)``, ``signIn(withAppleIDToken:)``, ``signOut()``, ``deleteAccount(password:)``, and ``profileDetails()`` continue to update ``KurozoraKit/authenticationKey`` and ``User/current`` on success and post `KUserIsSignedInDidChange`.

```swift
let response = try await KService.signIn(email: email, password: password).response()
_ = try await KService.signOut().response()
_ = try await KService.deleteAccount(password: password).response()
```

### General pattern

Endpoints not listed above follow the same shape: drop the `get` prefix, replace named-argument noise with builder methods, and call `.response()` at the end.

```swift
// Before
let notifications = try await KService.getNotifications()
let recap = try await KService.getRecap(for: "2024", month: "12")
let feed = try await KService.getFeedHome()

// After
let notifications = try await KService.notifications().response()
let recap = try await KService.recap(year: "2024", month: "12").response()
let feed = try await KService.feedHome().response()
```

## Renamed types

| Before                      | After               |
|-----------------------------|---------------------|
| `KKAPIError`                | `APIError`          |
| `KKSearchScope`             | `SearchScope`       |
| `KKSearchType`              | `SearchType`        |
| `KKSearchFilter`            | `SearchFilter`      |
| `KKLibrary.Kind`            | `LibraryKind`       |
| `KKLibrary.Status`          | `LibraryStatus`     |
| `KKLibrary.SortType`        | `LibrarySortType`   |
| `KKLibrary.SortType.Option` | `LibrarySortOption` |

## Generic responses

Most paginated response structs collapse into ``ResourceCollection``.

| Before                 | After                              |
|------------------------|------------------------------------|
| `ShowResponse`         | `ResourceCollection<Show>`         |
| `ShowIdentityResponse` | `ResourceCollection<ShowIdentity>` |
| `GameResponse`         | `ResourceCollection<Game>`         |

Non-standard responses are unchanged, although these will be unified at some point in the future: `SearchResponse`, `LibraryResponse`, `LibraryUpdateResponse`, `SignInResponse`, `OAuthResponse`, `SettingsResponse`, `LegalResponse`.

## Fetchable

Identity types now conform to ``Fetchable``, which exposes:

- `detailEndpoint`: the URL path for a single-resource fetch.
- `indexEndpoint`: the URL path for a batch fetch.
- `Response`: the associated response type, typically `ResourceCollection<T>`.

## Deployment targets

This stays unchanged: iOS 15, watchOS 10, and macOS 12.
