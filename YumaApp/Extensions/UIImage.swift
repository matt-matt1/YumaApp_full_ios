//
//  UIImage.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIImage
{
	//https://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
	
	/// Create an solid image of a color and optional size
	public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1))
	{
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		guard let cgImage = image?.cgImage 	else 	{ 	return nil 	}
		self.init(cgImage: cgImage)
	}
	
	//https://stackoverflow.com/questions/40882487/how-to-rotate-image-in-swift-3
	
	/// Rotates an image (by Radians). Eg. let rotatedImage = image.rotate(radians: .pi)
	func rotate(radians: CGFloat) -> UIImage
	{
		let rotatedSize = CGRect(origin: .zero, size: size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).integral.size
		UIGraphicsBeginImageContext(rotatedSize)
		if let context = UIGraphicsGetCurrentContext()
		{
			let origin = CGPoint(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
			context.translateBy(x: origin.x, y: origin.y)
			context.rotate(by: radians)
			draw(in: CGRect(x: -origin.x, y: -origin.y, width: size.width, height: size.height))
			let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			return rotatedImage ?? self
		}
		return self
	}
	/// Rotates an image with the amount in degrees
	func rotate(degrees: CGFloat) -> UIImage
	{
		let rotatedSize = CGRect(origin: .zero, size: size).applying(CGAffineTransform(rotationAngle: CGFloat(degrees * .pi/180))).integral.size
		UIGraphicsBeginImageContext(rotatedSize)
		if let context = UIGraphicsGetCurrentContext()
		{
			let origin = CGPoint(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
			context.translateBy(x: origin.x, y: origin.y)
			context.rotate(by: degrees * .pi/180)
			draw(in: CGRect(x: -origin.x, y: -origin.y, width: size.width, height: size.height))
			let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			return rotatedImage ?? self
		}
		return self
	}
	
}
