//
//  MediaStat.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 20/11/2021.
//  MIT License
//

import Foundation

/// A root object that stores information about a media stat resource.
public struct MediaStat: Codable, Sendable {
	// MARK: - Properties
	/// The count of ratings sorted from `0.5` to `5.0`.
	public let ratingCountList: [Int]

	/// The average of all ratings.
	public let ratingAverage: Double

	/// The total count of all ratings.
	public let ratingCount: Int

	/// The rank compared to all other models.
	public let rankGlobal: Int

	/// The rank compared to resources of the same model.
	public let rankTotal: Int

	/// The collective user sentiment.
	public let sentiment: String

	/// The percentage of ratings that are positive.
	public let positivePercentage: Double

	/// The collective user sentiment of how much the model is liked next to how it is rated.
	public let favoriteSentiment: String

	/// The total count of all favorites.
	public let favoriteCount: Int

	/// The share of raters who also favorited the model.
	public let favoriteShare: Double

	/// The distance between the share of raters who favorited the model and its rating, in standard deviations.
	public let sentimentGap: Double
}
