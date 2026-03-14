// swift-tools-version: 6.1

//  Package.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 02/10/2025.
//

import PackageDescription

let package = Package(
	name: "KurozoraKit",
	platforms: [
		.macOS(.v12),
		.iOS(.v15),
		.watchOS(.v10),
	],
	products: [
		.library(name: "KurozoraKit", targets: ["KurozoraKit"]),
	],
	dependencies: [
		.package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
	],
	targets: [
		.target(
			name: "KurozoraKit",
			dependencies: [
				.product(name: "KeychainAccess", package: "KeychainAccess"),
			],
			resources: [.copy("Resources/PrivacyInfo.xcprivacy")]
		),
		.testTarget(
			name: "KurozoraKitTests",
			dependencies: ["KurozoraKit"],
			path: "Tests/KurozoraKitTests"
		),
	],
	swiftLanguageModes: [.v5, .v6]
)
