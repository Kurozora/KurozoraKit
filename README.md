<p></p>

<p align="center"><img src=".github/Assets/KurozoraKit.png" width="200px"></p>

<p align="center">
    <sup><b>The magic behind Kurozora app</b></sup>
</p>

# KurozoraKit [![Swift 6](https://img.shields.io/badge/Swift%206-white.svg?style=flat&logo=Swift)](https://swift.org)  [![Apple Platform](https://img.shields.io/badge/iOS%20|%20iPadOS%20|%20macOS%20|%20watchOS-black?style=flat&logo=Apple)](https://apple.co/3CsQlKq) [![Kurozora Discord Server](https://img.shields.io/discord/449250093623934977?style=flat&label=&logo=Discord&logoColor=white&color=7289DA)](https://discord.gg/f3QFzGqsah) [![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](LICENSE)

 [KurozoraKit](https://developer.kurozora.app/kurozorakit) lets users manage their anime, manga, games and music library and access many other services from your app. When users provide permission to access their Kurozora account, they can use your app to share anime, add it to their library, and discover any of the thousands of content in the Kurozora catalog. If your app detects that the user is not yet a Kurozora member, you can offer them to create an account within your app.

KurozoraKit is designed to be:

* **🛠 Intuitive:** KurozoraKit is built with Swift, one of the **fast**, **modern**, **safe** and **interactive** programming languages.

* **🧵 Asynchronous:** By utilizing the power of Swift Concurrency, KurozoraKit is more readable and less prone to errors like data races and deadlocks by design.

* **✨ Magical:** The kit is carefully designed to work as efficient and reliable as you would expect it to.

* **📚 Documented:** With up to 100% documentation coverage.

* **⚙️ Reliable:** Built for the best [API](https://github.com/kurozora/kurozora-web). The way KurozoraKit works together with the Kurozora API is truly otherworldly.

# Requirements

- iOS 15.0+ / macOS 12+ / watchOS 10+
- Swift 6.0+

# Installation

## Swift Package Manager

KurozoraKit is available through [Swift Package Manager](https://swift.org/package-manager). To install it, simply add the package through Xcode. Go to `File > Add Package Dependencies...` and enter the following URL:

```text
https://github.com/Kurozora/KurozoraKit.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Kurozora/KurozoraKit.git", from: "2.0.0")
]
```

# Usage

KurozoraKit can be implemented using one line.

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
let appIdentifierPrefix = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String ?? ""
let keychain = Keychain(service: "AppName", accessGroup: "\(appIdentifierPrefix)com.company.shared")
    .synchronizable(true)
    .accessibility(.afterFirstUnlock)

// Pass the keychain object.
let services = KKServices(keychain: keychain)

// Pass KKServices.
let kurozoraKit = KurozoraKit(authenticationKey: "bearer-token")
    .services(services)
```

You can also be chain desired methods instead of passing data as parameter.

```swift
let services = KKServices().keychainDefaults(keychain)
let kurozoraKit = KurozoraKit()
    .authenticationKey("bearer-token")
    .services(services)
```

After setting up KurozoraKit you can use an API by calling its own method. For example, to get the explore page data, you do the following:

```swift
do {
    let response = try await kurozoraKit.getExplore()
    // Handle response...
} catch {
    // Handle error...
}
```

# Contributing

Read the [Contributing Guide](CONTRIBUTING) to learn about reporting issues, contributing code, and more ways to contribute.

# Security

Read our [Security Policy](SECURITY.md) to learn about reporting security issues.

# Getting in Touch

If you have any questions or just want to say hi, join the Kurozora [Discord](https://discord.gg/f3QFzGqsah) and drop a message on the #development channel.

# Code of Conduct

This project has a [Code of Conduct](CODE_OF_CONDUCT.md). By interacting with this repository, or community you agree to abide by its terms.

# More by Kurozora

- [Kurozora Android App](https://github.com/kurozora/kurozora-android) — Android client app
- [Kurozora Discord Bot](https://github.com/kurozora/kurozora-discord-bot) — A versatile Discord bot with access to Kurozora services
- [Kurozora iOS App](https://github.com/kurozora/kurozora-app) — iOS/iPadOS/MacOS client app
- [Kurozora Linux App](https://github.com/kurozora/kurozora-linux) — Linux client app
- [Kurozora Web](https://github.com/kurozora/kurozora-web) — Home to the Kurozora website and API
- [Kurozora Web Extension](https://github.com/Kurozora/kurozora-extension) — Anime, Manga and Game search engine for FireFox and Chrome

# License

KurozoraKit is an Open Source project covered by the [MIT License](LICENSE).
