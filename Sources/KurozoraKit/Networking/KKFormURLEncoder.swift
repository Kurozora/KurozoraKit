//
//  KKFormURLEncoder.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/04/2026.
//  MIT License
//

import Foundation

/// A URL-form encoder for `application/x-www-form-urlencoded` request bodies.
internal enum KKFormURLEncoder {
	// MARK: - Public API
	/// Encodes a parameter dictionary as an `application/x-www-form-urlencoded` string.
	static func encode(_ parameters: [String: Any]) -> String {
		return queryItems(from: parameters)
			.map { item in
				let name = Self.escape(item.name)
				let value = Self.escape(item.value ?? "")
				return "\(name)=\(value)"
			}
			.joined(separator: "&")
	}

	/// Produces `URLQueryItem`s for the given parameters, expanding arrays and dictionaries using bracketed keys.
	static func queryItems(from parameters: [String: Any]) -> [URLQueryItem] {
		var items: [URLQueryItem] = []
		for (key, value) in parameters.sorted(by: { $0.key < $1.key }) {
			items.append(contentsOf: Self.queryComponents(key: key, value: value))
		}
		return items
	}

	// MARK: - Recursion
	private static func queryComponents(key: String, value: Any) -> [URLQueryItem] {
		var components: [URLQueryItem] = []

		switch value {
		case let dictionary as [String: Any]:
			for (nestedKey, nestedValue) in dictionary.sorted(by: { $0.key < $1.key }) {
				components.append(contentsOf: Self.queryComponents(key: "\(key)[\(nestedKey)]", value: nestedValue))
			}
		case let array as [Any]:
			for item in array {
				components.append(contentsOf: Self.queryComponents(key: "\(key)[]", value: item))
			}
		case let bool as Bool:
			components.append(URLQueryItem(name: key, value: bool ? "1" : "0"))
		case let number as NSNumber:
			// NSNumber carries booleans as a distinct objCType; the `as Bool` case above
			// handles native Swift Bool. This catches numeric values that round-trip
			// through Foundation.
			if CFGetTypeID(number) == CFBooleanGetTypeID() {
				components.append(URLQueryItem(name: key, value: number.boolValue ? "1" : "0"))
			} else {
				components.append(URLQueryItem(name: key, value: "\(number)"))
			}
		default:
			components.append(URLQueryItem(name: key, value: "\(value)"))
		}

		return components
	}

	// MARK: - Percent escaping
	/// Percent-escapes a string for use in a form-URL-encoded body.
	private static func escape(_ string: String) -> String {
		var allowed = CharacterSet.urlQueryAllowed
		allowed.remove(charactersIn: "#?/=&+")
		return string.addingPercentEncoding(withAllowedCharacters: allowed) ?? string
	}
}
