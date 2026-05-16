//
//  KKWebSocket.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 16/05/2026.
//  MIT License
//

import Foundation
import os.log
#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif

/// A realtime WebSocket client that publishes inbound notification events to subscribers.
internal actor KKWebSocket {
	// MARK: - Constants
	private static let client = "kurozora-kit"
	private static let protocolVersion = "7"
	private static let clientVersion = "1.0"
	private static let activityTimeout: TimeInterval = 120
	private static let heartbeatCheckInterval: TimeInterval = 30
	private static let maxReconnectDelay: TimeInterval = 30
	private static let maxReconnectAttempts = 16
	private static let requestTimeout: TimeInterval = 30
	private static let resourceTimeout: TimeInterval = 60
	private static let logSubsystem = "app.kurozora.KurozoraKit"
	private static let logCategory = "WebSocket"

	// MARK: - Properties
	/// The public realtime app key.
	private nonisolated let appKey: String

	private nonisolated let logger = Logger(subsystem: KKWebSocket.logSubsystem, category: KKWebSocket.logCategory)
	private nonisolated let session: URLSession

	/// The socket identifier assigned during the most recent handshake.
	private var _socketID: String?

	/// The socket identifier assigned during the most recent handshake.
	var socketID: String? {
		return self._socketID
	}

	private weak var kurozoraKit: KurozoraKit?

	private var task: URLSessionWebSocketTask?
	private var receiveTask: Task<Void, Never>?
	private var heartbeatTask: Task<Void, Never>?
	private var reconnectTask: Task<Void, Never>?
	private var reconnectAttempt = 0
	private var subscribedChannel: String?
	private var lastInboundAt: Date = Date()

	private var _isSignedIn: Bool = false
	private var _isForegrounded: Bool = true

	private var userNotificationContinuations: [UUID: AsyncStream<UserNotification.Event>.Continuation] = [:]

	private var observerTokens: [NSObjectProtocol] = []

	// MARK: - Initializers
	/// Creates a WebSocket bound to the given realtime app key.
	///
	/// - Parameter appKey: The public realtime app key.
	internal init(appKey: String) {
		self.appKey = appKey

		let sessionConfiguration = URLSessionConfiguration.default
		sessionConfiguration.timeoutIntervalForRequest = KKWebSocket.requestTimeout
		sessionConfiguration.timeoutIntervalForResource = KKWebSocket.resourceTimeout
		self.session = URLSession(configuration: sessionConfiguration)
	}

	// MARK: - Binding
	/// Binds the WebSocket to its owning ``KurozoraKit`` and starts observing auth + lifecycle notifications.
	internal func _bind(to ref: KurozoraKitReference) {
		self.kurozoraKit = ref.instance
		self._isSignedIn = User.isSignedIn
		self.startObservers()
		self.reconcile()
	}

	private func startObservers() {
		guard self.observerTokens.isEmpty else { return }

		let signInToken = NotificationCenter.default.addObserver(
			forName: .KUserIsSignedInDidChange,
			object: nil,
			queue: nil
		) { [weak self] _ in
			Task { [weak self] in
				await self?.handleSignInStateChange()
			}
		}
		self.observerTokens.append(signInToken)

		#if canImport(UIKit) && !os(watchOS)
		let backgroundToken = NotificationCenter.default.addObserver(
			forName: UIApplication.didEnterBackgroundNotification,
			object: nil,
			queue: nil
		) { [weak self] _ in
			Task { [weak self] in
				await self?.handleForegroundChange(isForegrounded: false)
			}
		}
		self.observerTokens.append(backgroundToken)

		let foregroundToken = NotificationCenter.default.addObserver(
			forName: UIApplication.willEnterForegroundNotification,
			object: nil,
			queue: nil
		) { [weak self] _ in
			Task { [weak self] in
				await self?.handleForegroundChange(isForegrounded: true)
			}
		}
		self.observerTokens.append(foregroundToken)
		#endif
	}

	private func handleSignInStateChange() async {
		let isSignedIn = await MainActor.run { User.isSignedIn }
		guard self._isSignedIn != isSignedIn else { return }
		self._isSignedIn = isSignedIn
		self.reconcile()
	}

	private func handleForegroundChange(isForegrounded: Bool) {
		guard self._isForegrounded != isForegrounded else { return }
		self._isForegrounded = isForegrounded
		self.reconcile()
	}

	// MARK: - Reconciliation
	private func reconcile() {
		let shouldBeConnected = self._isSignedIn && self._isForegrounded

		if shouldBeConnected, self.task == nil {
			self.connect()
		} else if !shouldBeConnected, self.task != nil {
			self.disconnect()
		}
	}

	// MARK: - Event stream
	/// A new stream of typed user notification events. Each call registers an independent consumer.
	internal func userNotificationEvents() -> AsyncStream<UserNotification.Event> {
		return AsyncStream { continuation in
			let id = UUID()
			self.userNotificationContinuations[id] = continuation
			continuation.onTermination = { [weak self] _ in
				Task { [weak self] in
					await self?.removeUserNotificationContinuation(id)
				}
			}
		}
	}

	private func removeUserNotificationContinuation(_ id: UUID) {
		self.userNotificationContinuations.removeValue(forKey: id)
	}

	private func yield(_ event: UserNotification.Event) {
		for (_, continuation) in self.userNotificationContinuations {
			continuation.yield(event)
		}
	}

	// MARK: - Lifecycle
	private func connect() {
		guard !self.appKey.isEmpty else {
			self.logger.error("WebSocket appKey is empty — refusing to connect")
			return
		}
		guard let kurozoraKit = self.kurozoraKit else {
			self.logger.error("WebSocket has no bound KurozoraKit — refusing to connect")
			return
		}
		guard let baseURL = URL(string: kurozoraKit.apiEndpoint.baseURL) else { return }
		guard let url = self.connectionURL(for: baseURL) else { return }

		self.reconnectTask?.cancel()
		self.reconnectTask = nil

		var resolvedHeaders = kurozoraKit.headers
		if !kurozoraKit.authenticationKey.isEmpty {
			resolvedHeaders["Authorization"] = "Bearer \(kurozoraKit.authenticationKey)"
		}

		var request = URLRequest(url: url)
		for (key, value) in resolvedHeaders {
			request.setValue(value, forHTTPHeaderField: key)
		}

		let webSocketTask = self.session.webSocketTask(with: request)
		self.task = webSocketTask
		self.subscribedChannel = nil
		self.lastInboundAt = Date()
		webSocketTask.resume()

		self.logger.info("WebSocket connecting to \(url.absoluteString, privacy: .public)")
		self.startReceiveLoop()
		self.startHeartbeatLoop()
	}

	private func disconnect() {
		self.reconnectAttempt = 0
		self.reconnectTask?.cancel()
		self.reconnectTask = nil
		self.heartbeatTask?.cancel()
		self.heartbeatTask = nil
		self.receiveTask?.cancel()
		self.receiveTask = nil
		self.task?.cancel(with: .normalClosure, reason: nil)
		self.task = nil
		self.subscribedChannel = nil
		self._socketID = nil
		self.logger.info("WebSocket disconnected")
	}

	// MARK: - URL building
	private nonisolated func connectionURL(for baseURL: URL) -> URL? {
		let withPath = baseURL.appendingPathComponent("app/\(self.appKey)")
		guard var components = URLComponents(url: withPath, resolvingAgainstBaseURL: false) else { return nil }

		switch components.scheme?.lowercased() {
		case "https": components.scheme = "wss"
		case "http": components.scheme = "ws"
		case "wss", "ws": break
		default: components.scheme = "wss"
		}

		components.queryItems = [
			URLQueryItem(name: "protocol", value: KKWebSocket.protocolVersion),
			URLQueryItem(name: "client", value: KKWebSocket.client),
			URLQueryItem(name: "version", value: KKWebSocket.clientVersion),
			URLQueryItem(name: "flash", value: "false")
		]
		return components.url
	}

	// MARK: - Receive loop
	private func startReceiveLoop() {
		self.receiveTask?.cancel()
		self.receiveTask = Task { [weak self] in
			await self?.runReceiveLoop()
		}
	}

	private func runReceiveLoop() async {
		while !Task.isCancelled {
			guard let task = self.task else { return }

			do {
				let message = try await task.receive()
				self.lastInboundAt = Date()
				self.handle(message: message)
			} catch {
				self.logger.error("WebSocket receive failed: \(error.localizedDescription, privacy: .public)")
				self.handleDisconnect(for: task)
				return
			}
		}
	}

	private func handle(message: URLSessionWebSocketTask.Message) {
		let data: Data
		switch message {
		case .string(let string):
			data = Data(string.utf8)
		case .data(let payload):
			data = payload
		@unknown default:
			return
		}

		guard let envelope = try? JSONDecoder().decode(Frame.self, from: data) else {
			self.logger.debug("WebSocket received undecodable frame")
			return
		}

		switch envelope.event {
		case "pusher:connection_established":
			self.handleConnectionEstablished(envelope: envelope)
		case "pusher:ping":
			self.send(json: ["event": "pusher:pong"])
		case "pusher:pong":
			break
		case "pusher:error":
			self.logger.error("WebSocket server error: \(envelope.data ?? "<no data>", privacy: .public)")
		case "pusher_internal:subscription_succeeded":
			self.logger.info("WebSocket subscription succeeded for \(envelope.channel ?? "<unknown>", privacy: .public)")
		default:
			self.handleBroadcast(envelope: envelope)
		}
	}

	// MARK: - Protocol events
	private func handleConnectionEstablished(envelope: Frame) {
		guard
			let dataString = envelope.data,
			let dataBytes = dataString.data(using: .utf8),
			let connection = try? JSONDecoder().decode(ConnectionEstablished.self, from: dataBytes)
		else {
			self.logger.error("WebSocket handshake missing socket identifier")
			return
		}

		self.reconnectAttempt = 0
		self._socketID = connection.socketID

		Task { [weak self] in
			await self?.authorizeAndSubscribe(socketID: connection.socketID)
		}
	}

	private func handleBroadcast(envelope: Frame) {
		if let event = UserNotification.decodeEvent(from: envelope) {
			self.logger.info("WebSocket broadcast \(envelope.event, privacy: .public) on \(envelope.channel ?? "<unknown>", privacy: .public)")
			self.yield(event)
		} else {
			self.logger.debug("WebSocket unhandled broadcast \(envelope.event, privacy: .public)")
		}
	}

	// MARK: - Authorize + subscribe
	private func authorizeAndSubscribe(socketID: String) async {
		guard let kurozoraKit = self.kurozoraKit else { return }

		let context = RequestContext(from: kurozoraKit)

		do {
			let response = try await BroadcastingAuthRequest(context: context, socketID: socketID).response()
			self.sendSubscription(channel: response.data.channelName, auth: response.data.auth)
		} catch {
			self.logger.error("WebSocket channel authorization failed: \(error.localizedDescription, privacy: .public)")
		}
	}

	private func sendSubscription(channel: String, auth: String) {
		self.subscribedChannel = channel
		self.logger.info("WebSocket subscribing to \(channel, privacy: .public)")
		let frame: [String: Any] = [
			"event": "pusher:subscribe",
			"data": [
				"channel": channel,
				"auth": auth
			]
		]
		self.send(json: frame)
	}

	// MARK: - Outbound
	private func send(json: [String: Any]) {
		guard let task = self.task else { return }
		guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
		guard let string = String(data: data, encoding: .utf8) else { return }

		let logger = self.logger
		task.send(.string(string)) { error in
			if let error = error {
				logger.error("WebSocket send error: \(error.localizedDescription, privacy: .public)")
			}
		}
	}

	// MARK: - Heartbeat
	private func startHeartbeatLoop() {
		self.heartbeatTask?.cancel()
		self.heartbeatTask = Task { [weak self] in
			await self?.runHeartbeatLoop()
		}
	}

	private func runHeartbeatLoop() async {
		let interval = KKWebSocket.heartbeatCheckInterval
		let timeout = KKWebSocket.activityTimeout

		while !Task.isCancelled {
			try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
			guard self.task != nil else { return }
			let elapsed = Date().timeIntervalSince(self.lastInboundAt)
			if elapsed >= timeout {
				self.send(json: ["event": "pusher:ping"])
			}
		}
	}

	// MARK: - Reconnect
	private func handleDisconnect(for task: URLSessionWebSocketTask) {
		guard self.task === task else { return }
		self.task = nil
		self.receiveTask = nil
		self.heartbeatTask?.cancel()
		self.heartbeatTask = nil
		self.subscribedChannel = nil
		self._socketID = nil

		let shouldReconnect = self._isSignedIn && self._isForegrounded
		if shouldReconnect {
			self.scheduleReconnect()
		}
	}

	private func scheduleReconnect() {
		let attempt = self.reconnectAttempt
		self.reconnectAttempt = min(attempt + 1, KKWebSocket.maxReconnectAttempts)

		let cap = KKWebSocket.maxReconnectDelay
		let base = min(pow(2.0, Double(attempt)), cap)
		let jitter = Double.random(in: -0.2...0.2) * base
		let delay = max(1.0, base + jitter)
		self.logger.info("WebSocket scheduling reconnect in \(delay, privacy: .public)s (attempt \(attempt + 1, privacy: .public))")

		self.reconnectTask?.cancel()
		self.reconnectTask = Task { [weak self] in
			try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
			guard let self = self, !Task.isCancelled else { return }
			await self.attemptReconnect()
		}
	}

	private func attemptReconnect() async {
		guard self._isSignedIn, self._isForegrounded else { return }
		self.connect()
	}
}

// MARK: - Wire types
internal extension KKWebSocket {
	/// A single decoded frame.
	struct Frame: Decodable {
		let event: String
		let channel: String?
		let data: String?
	}
}

/// A Sendable wrapper holding a weak reference to a ``KurozoraKit/KurozoraKit`` instance.
internal struct KurozoraKitReference: @unchecked Sendable {
	weak var instance: KurozoraKit?

	init(_ kurozoraKit: KurozoraKit) {
		self.instance = kurozoraKit
	}
}

private extension KKWebSocket {
	/// The decoded connection-established payload.
	struct ConnectionEstablished: Decodable {
		let socketID: String

		private enum CodingKeys: String, CodingKey {
			case socketID = "socket_id"
		}
	}
}
