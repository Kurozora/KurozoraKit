//
//  KurozoraItem.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 14/11/2025.
//

import Foundation

/// A protocol with basic requirements for Kurozora items.
public protocol KurozoraItem: Sendable {
	/// The unique identifier for the Kurozora item.
	var id: KurozoraItemID { get }
}
