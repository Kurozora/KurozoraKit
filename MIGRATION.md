# Migrating from KurozoraKit 1.x to 2.0

2.0 is a cleanup release. We dropped TRON and Alamofire and rewrote the networking layer on top of URLSession. The public API is mostly the same shape, but every endpoint method now returns `async throws -> Response` directly instead of a `RequestSender`.

If your app was already written with `try await ...value`, the migration is mostly deleting `.value`. If you were still using the completion-handler flavor of `RequestSender`, expect a bit more work.

## TL;DR

1. Bump the KurozoraKit version in your Package.swift to 2.0.0.
2. Delete every `.value` at the end of a `try await KService.foo().value` call.
3. If you pattern-matched on `KKAPIError.errorDescription` or `recoverySuggestion`, switch to `error.message`.
4. If you passed a `[Plugin]` into `KurozoraAPI.custom(url:plugins:)`, switch to `KurozoraAPIOptions`.

That covers the 99% case.

## Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/Kurozora/KurozoraKit.git", from: "2.0.0"),
]
```

TRON and Alamofire are no longer pulled in. If your own app was using them through KurozoraKit, you will need to add them as explicit dependencies.

## Call sites

Every method that used to return `RequestSender<T, KKAPIError>` now returns `async throws -> T`. That means you can delete the `.value` suffix you had to write before.

### Before

```swift
let response = try await KService.getDetails(forUser: userIdentity).value
self.user = response.data.first
```

### After

```swift
let response = try await KService.getDetails(forUser: userIdentity)
self.user = response.data.first
```

Error handling is unchanged. `catch let error as KKAPIError` still works the same way.

### If you were still on completion handlers

The `RequestSender` type is gone entirely. Anywhere you had something like:

```swift
let request = KService.getDetails(forUser: userIdentity)
request.sender().perform { result in ... }
```

you now need to wrap the call in a `Task`:

```swift
Task {
    do {
        let response = try await KService.getDetails(forUser: userIdentity)
        // handle response
    } catch {
        // handle error
    }
}
```

There is no shim for the old callback style. If you have a lot of these, grep for `.sender()` and port them one at a time.

## KKAPIError

`KKAPIError` used to inherit from `TRON.APIError`, which gave it a pile of `Error`-protocol helpers like `errorDescription`, `recoverySuggestion`, and `failureReason`. Those are gone. In practice the only property anyone used from that set was `message`, which still works the same way.

The new shape:

```swift
public final class KKAPIError: Error {
    public let response: HTTPURLResponse?   // unchanged
    public let errors: [KKError]            // new, was fileprivate before
    public let underlying: Error?           // new, the URLError/DecodingError if any
    public let request: URLRequest?         // new, for diagnostics
    public var statusCode: Int? { response?.statusCode }   // convenience
    public var message: String { ... }      // unchanged
}
```

### If you were checking status codes

`error.response?.statusCode` still works, and there is now a shorter `error.statusCode` if you prefer.

```swift
} catch let error as KKAPIError where error.statusCode == 401 {
    // token expired, sign out
}
```

### If you were using errorDescription / recoverySuggestion / failureReason

Replace them with `error.message` (for user-facing copy) or `error.underlying?.localizedDescription` (if you want the raw URLError/DecodingError text).

## KurozoraAPI.custom

The `custom` case no longer takes a list of TRON plugins. It takes an optional `KurozoraAPIOptions` struct instead.

### Before

```swift
let api = KurozoraAPI.custom("https://staging.kurozora.app/v1/", [NetworkLoggerPlugin()])
```

### After

```swift
let api = KurozoraAPI.custom(
    "https://staging.kurozora.app/v1/",
    KurozoraAPIOptions(logLevel: .debug)
)
```

`KurozoraAPIOptions` exposes what the old plugin system was mostly used for:

```swift
public struct KurozoraAPIOptions: Sendable {
    public var logLevel: LogLevel        // .off, .info, .debug
    public var timeout: TimeInterval     // default 60
    public var additionalHeaders: [String: String]
}
```

Logging now goes through `os.Logger` with subsystem `app.kurozora.KurozoraKit` and category `Networking`, so you can filter it in Console.app.

## Dependencies you were reaching through

If your app code had `import Alamofire` or `import TRON` anywhere and was only getting those modules because KurozoraKit pulled them in, your build will now fail with "no such module". Either:

- Drop the import if you were not actually using it, or
- Add the dependency explicitly to your own Package.swift.

## Deployment target

No change. Still iOS 15, watchOS 10, macOS 12.

## Anything I missed?

If you hit something this doc does not cover, open an issue. The intent was for the migration to be close to mechanical for most consumers. If it is not, I want to hear about it.
