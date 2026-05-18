//
//  KKEndpoint+Stickers.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 18/05/2026.
//  MIT License
//

import Foundation

// MARK: - WhatsApp
extension KKEndpoint.Stickers {
	/// The set of available WhatsApp sticker pack API endpoint types.
	internal enum WhatsApp {
		// MARK: - Cases
		/// The endpoint to the Kuro-chan WhatsApp sticker pack pasteboard bundle.
		case bundle

		// MARK: - Properties
		/// The endpoint value of the WhatsApp sticker API type.
		var endpointValue: String {
			switch self {
			case .bundle:
				return "stickers/whatsapp/kurochan/bundle"
			}
		}
	}
}
