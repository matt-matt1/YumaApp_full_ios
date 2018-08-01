//
//  UIColor.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIColor
{
	//https://medium.com/@valv0/a-swift-extension-for-string-and-html-8cfb7477a510
	var hexString: String?
	{
		if let components = self.cgColor.components
		{
			let r = components[0]
			let g = components[1]
			let b = components[2]
			return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
		}
		return nil
	}

	/// eg. (hex: "ffffff, alpha: 3.0) or (hex: "#ffffff, alpha: 3.0)
	convenience init(hex: String, alpha: CGFloat = 1.0)
	{
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) { 	cString.removeFirst() 	}
		
		if ((cString.count) != 6)
		{
			self.init(hex: "ff0000") // return red color for wrong hex input
			return
		}
		
		var rgbValue: UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				  alpha: alpha)
	}

	/// A color object whose RGB values are 0.1, 0.5, and 0.9 and whose alpha value is 1.
	static let blueApple = UIColor(red: 0.1520819664, green: 0.5279997587, blue: 0.985317409, alpha: 1)
}
