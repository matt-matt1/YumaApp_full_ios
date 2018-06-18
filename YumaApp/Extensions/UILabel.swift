//
//  UILabel.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UILabel
{
	/// Makes a whole UILabel underlined (in lineColor color)
	func underline(lineColor: UIColor)
	{
		if let textString = self.text
		{
			let attributedString = NSMutableAttributedString(string: textString)
			attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
			attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: lineColor, range: NSRange(location: 0, length: attributedString.length))
			attributedText = attributedString
		}
	}
	/// Set text strikethrough and line height in UILabel
	func setStrikethrough(text: String, color: UIColor = UIColor.black)
	{
		let attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.strikethroughColor : color])
		self.attributedText = attributedText
	}
	
	func setLineHeight(lineHeight: CGFloat)
	{
		let text = self.text
		if let text = text
		{
			let attributeString = NSMutableAttributedString(string: text)
			let style = NSMutableParagraphStyle()
			
			style.lineSpacing = lineHeight
			attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: style, range: NSMakeRange(0, text.count))
			self.attributedText = attributeString
		}
	}
}
