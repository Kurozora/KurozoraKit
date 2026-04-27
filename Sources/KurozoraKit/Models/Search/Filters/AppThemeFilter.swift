//
//  AppThemeFilter.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 26/04/2023.
//  MIT License
//

import Foundation

/// A set of filter options for querying app themes.
public struct AppThemeFilter: Equatable {
	// MARK: - Properties
	/// The minimum download count to filter by.
	public let downloadCount: Int?

	/// The UI status bar style identifier to filter by.
	public let uiStatusBarStyle: Int?

	/// The theme version string to filter by.
	public let version: String?

	// MARK: - Initializers
	public init(downloadCount: Int?, uiStatusBarStyle: Int?, version: String?) {
		self.downloadCount = downloadCount
		self.uiStatusBarStyle = uiStatusBarStyle
		self.version = version
	}
}

// MARK: - Filterable
extension AppThemeFilter: Filterable {
	public func toFilterArray() -> [String: Any?] {
		return [
			"download_count": self.downloadCount,
			"ui_status_bar_style": self.uiStatusBarStyle,
			"version": self.version
		]
	}
}
