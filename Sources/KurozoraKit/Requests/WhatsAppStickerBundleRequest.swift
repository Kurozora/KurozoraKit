//
//  WhatsAppStickerBundleRequest.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 19/05/2026.
//  MIT License
//

import Foundation

/// A request that downloads the Kuro-chan WhatsApp sticker pack pasteboard bundle.
public struct WhatsAppStickerBundleRequest: Sendable {
	// MARK: - Properties
	private let context: RequestContext

	// MARK: - Initializers
	internal init(context: RequestContext) {
		self.context = context
	}

	// MARK: - Execution
	/// Executes the request and returns the raw bytes of the sticker pack pasteboard payload.
	///
	/// - Returns: The serialized pasteboard payload ready to be handed off to WhatsApp.
	public func response() async throws -> Data {
		return try await self.context.client.download(
			path: KKEndpoint.Stickers.WhatsApp.bundle.endpointValue,
			headers: self.context.headers
		)
	}
}
