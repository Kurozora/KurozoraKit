//
//  Array+Chunked.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 27/04/2026.
//  MIT License
//

import Foundation

extension Array {
	/// Splits the array into contiguous subarrays of at most `size` elements.
	///
	/// - Parameter size: The size of the chunk.
	///
	/// - Returns: the array split into contiguous subarrays of at most `size` elements.
	internal func chunked(by size: Int) -> [[Element]] {
		guard size > 0 else { return [self] }
		return stride(from: 0, to: self.count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, self.count)])
		}
	}
}
