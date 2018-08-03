//
//  UINavigationBar.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UINavigationBar
{
//	func setGradientBackground(colors: [UIColor])
//	{
//		var updatedFrame = bounds
//		updatedFrame.size.height += self.frame.maxY//44//navigationBar.frame.maxY
//		let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
//		setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
//	}
	/// Applies a background gradient with the given colors
	//
	//eg.
	//navigationController?.navigationBar.applyNavigationGradient(colors: [UIColor.red , UIColor.yellow])
	//
	func applyNavigationGradient(colors: [UIColor], isVertical: Bool = true)
	{
		let frameAndStatusBar: CGRect = self.bounds
//		frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
//		frameAndStatusBar.size.height += 44
		//let a = self.frame.maxY
		
		if (isVertical)
		{
			setBackgroundImage(UINavigationBar.gradientV(size: frameAndStatusBar.size, colors: colors), for: .default)
		}
		else
		{
			setBackgroundImage(UINavigationBar.gradientH(size: frameAndStatusBar.size, colors: colors), for: .default)
		}
	}
	
	/// Creates a horizontal gradient image with the given settings
	static func gradientH(size : CGSize, colors : [UIColor]) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
	/// Creates a vertical gradient image with the given settings
	static func gradientV(size : CGSize, colors : [UIColor]) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: size.height), options: [])
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}
