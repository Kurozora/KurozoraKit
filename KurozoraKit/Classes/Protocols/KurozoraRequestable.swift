//
//  KurozoraRequestable.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 29/10/2025.
//

import Foundation

/// A protocol for Kurozora items that your app can fetch by using a library request.
public protocol KurozoraRequestable: Decodable {
	/// The type of Kurozora item included in the response.
	associatedtype Item: KurozoraItem

	/// The data included in the response for a requestable object request.
	var data: [Item] { get }
}
