//
//  UIButton.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIButton
{
	/// Makes a whole UIButton underlined (in lineColor color)
	func underline(lineColor: UIColor)
	{
		if let text = self.titleLabel?.text
		{
			let attributedString = NSMutableAttributedString(string: text)
			attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
			attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: lineColor, range: NSRange(location: 0, length: text.count))
			self.setAttributedTitle(attributedString, for: .normal)
		}
	}
}
