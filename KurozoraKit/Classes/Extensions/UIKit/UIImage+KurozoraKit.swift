//
//  UIImage+KurozoraKit.swift
//  KurozoraKit
//
//  Created by Khoren Katklian on 13/03/2026.
//

import UIKit

extension UIImage {
	/// Resizes the image to fit within the specified maximum dimensions, preserving aspect ratio.
	/// Images smaller than the dimensions are not expanded.
	///
	/// - Parameters:
	///    - maxWidth: The maximum width allowed.
	///    - maxHeight: The maximum height allowed.
	///
	/// - Returns: The resized image if larger than max dimensions, otherwise the original image.
	public func resized(maxWidth: CGFloat, maxHeight: CGFloat) -> UIImage {
		let currentWidth = self.size.width
		let currentHeight = self.size.height

		guard currentWidth > maxWidth || currentHeight > maxHeight else {
			return self
		}

		let widthRatio = maxWidth / currentWidth
		let heightRatio = maxHeight / currentHeight
		let scaleFactor = min(widthRatio, heightRatio)

		let newSize = CGSize(
			width: currentWidth * scaleFactor,
			height: currentHeight * scaleFactor
		)

		let renderer = UIGraphicsImageRenderer(size: newSize)
		return renderer.image { _ in
			self.draw(in: CGRect(origin: .zero, size: newSize))
		}
	}

	/// Scales the image to fill the specified dimensions and crops to exactly match.
	/// Images smaller than the dimensions are not expanded.
	///
	/// - Parameters:
	///    - width: The target width.
	///    - height: The target height.
	///
	/// - Returns: The cropped and resized image, or the original if already smaller than target.
	public func resizedAndCropped(to width: CGFloat, height: CGFloat) -> UIImage {
		guard self.size.width > width || self.size.height > height else {
			return self
		}

		let targetSize = CGSize(width: width, height: height)

		let widthRatio = targetSize.width / self.size.width
		let heightRatio = targetSize.height / self.size.height

		let scaleFactor = max(widthRatio, heightRatio)

		let scaledSize = CGSize(
			width: self.size.width * scaleFactor,
			height: self.size.height * scaleFactor
		)

		let renderer = UIGraphicsImageRenderer(size: targetSize)
		return renderer.image { context in
			let origin = CGPoint(
				x: (targetSize.width - scaledSize.width) / 2,
				y: (targetSize.height - scaledSize.height) / 2
			)
			self.draw(in: CGRect(origin: origin, size: scaledSize))
		}
	}

	/// Saves the image to a temporary file with the specified maximum dimensions and compression quality.
	///
	/// - Parameters:
	///    - maxWidth: The maximum width allowed.
	///    - maxHeight: The maximum height allowed.
	///    - compressionQuality: The compression quality for JPEG encoding (0.0 to 1.0).
	///
	/// - Returns: The URL of the saved file, or `nil` if saving failed.
	public func saveToTemporaryFile(maxWidth: CGFloat, maxHeight: CGFloat, compressionQuality: CGFloat = 0.8) -> URL? {
		let resizedImage = self.resized(maxWidth: maxWidth, maxHeight: maxHeight)

		guard let data = resizedImage.jpegData(compressionQuality: compressionQuality) else {
			return nil
		}

		let imageName = UUID().uuidString + ".jpg"
		let imageURL = FileManager.default.temporaryDirectory.appendingPathComponent(imageName)

		do {
			try data.write(to: imageURL, options: [.atomic])
			return imageURL
		} catch {
			print("Failed to save image: \(error)")
			return nil
		}
	}

	/// Saves the image to a temporary file, scaled to fill and cropped to exact dimensions.
	///
	/// - Parameters:
	///    - width: The target width.
	///    - height: The target height.
	///    - compressionQuality: The compression quality for JPEG encoding (0.0 to 1.0).
	///
	/// - Returns: The URL of the saved file, or `nil` if saving failed.
	public func saveToTemporaryFile(width: CGFloat, height: CGFloat, compressionQuality: CGFloat = 0.8) -> URL? {
		let resizedImage = self.resizedAndCropped(to: width, height: height)

		guard let data = resizedImage.jpegData(compressionQuality: compressionQuality) else {
			return nil
		}

		let imageName = UUID().uuidString + ".jpg"
		let imageURL = FileManager.default.temporaryDirectory.appendingPathComponent(imageName)

		do {
			try data.write(to: imageURL, options: [.atomic])
			return imageURL
		} catch {
			print("Failed to save image: \(error)")
			return nil
		}
	}
}

extension URL {
	/// Loads the image from this URL, resizes it to the specified dimensions, and saves to a temporary file.
	///
	/// - Parameters:
	///    - maxWidth: The maximum width allowed.
	///    - maxHeight: The maximum height allowed.
	///    - compressionQuality: The compression quality for JPEG encoding (0.0 to 1.0).
	///
	/// - Returns: The URL of the resized image file, or `nil` if loading/resizing failed.
	public func saveImageToTemporaryFile(maxWidth: CGFloat, maxHeight: CGFloat, compressionQuality: CGFloat = 0.8) -> URL? {
		guard let imageData = try? Data(contentsOf: self),
			  let image = UIImage(data: imageData) else {
			return nil
		}

		return image.saveToTemporaryFile(maxWidth: maxWidth, maxHeight: maxHeight, compressionQuality: compressionQuality)
	}

	/// Loads the image from this URL, scales it to fill and crops to exact dimensions, then saves.
	///
	/// - Parameters:
	///    - width: The target width.
	///    - height: The target height.
	///    - compressionQuality: The compression quality for JPEG encoding (0.0 to 1.0).
	///
	/// - Returns: The URL of the resized image file, or `nil` if loading/resizing failed.
	public func saveImageToTemporaryFile(width: CGFloat, height: CGFloat, compressionQuality: CGFloat = 0.8) -> URL? {
		guard let imageData = try? Data(contentsOf: self),
			  let image = UIImage(data: imageData) else {
			return nil
		}

		return image.saveToTemporaryFile(width: width, height: height, compressionQuality: compressionQuality)
	}
}
