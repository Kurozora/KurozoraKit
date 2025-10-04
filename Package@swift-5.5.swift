// swift-tools-version: 5.5

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
	],
    products: [
        .library(name: "KurozoraKit", targets: ["KurozoraKit"]),
    ],
	dependencies: [
		.package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
		.package(url: "https://github.com/MLSDev/TRON.git", from: "5.5.0-beta.1"),
	],
	targets: [
		.target(
			name: "KurozoraKit",
			dependencies: [
				.product(name: "KeychainAccess", package: "KeychainAccess"),
				.product(name: "TRON", package: "TRON"),
			],
			path: "KurozoraKit",
			resources: [.copy("Assets/PrivacyInfo.xcprivacy")]
		),
	],
	swiftLanguageVersions: [.v5]
)
