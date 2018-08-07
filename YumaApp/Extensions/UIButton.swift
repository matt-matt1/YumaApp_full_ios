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
	//https://gist.github.com/freedom27/c709923b163e26405f62b799437243f4
/*	private var badgeLayer: CAShapeLayer? {
		if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
			return b as? CAShapeLayer
		} else {
			return nil
		}
	}
	
	func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true , addedView:UIView?) {
		guard let view = addedView else { return }
		
		badgeLayer?.removeFromSuperlayer()
		
		var badgeWidth = 8
		var numberOffset = 4
		
		if number > 9 {
			badgeWidth = 12
			numberOffset = 6
		}
		
		// Initialize Badge
		let badge = CAShapeLayer()
		let radius = CGFloat(7)
		let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
		badge.drawRoundedRect(rect: CGRect(x: offset.x, y: offset.y, width: width, height: height), andColor: color, filled: filled)//.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
		view.layer.addSublayer(badge)
		
		// Initialiaze Badge's label
		let label = CATextLayer()
		label.string = "\(number)"
		label.alignmentMode = kCAAlignmentCenter
		label.fontSize = 11
		label.frame = CGRect(origin: CGPoint(x: location.x - CGFloat(numberOffset), y: offset.y), size: CGSize(width: badgeWidth, height: 16))
		label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
		label.backgroundColor = UIColor.clear.cgColor
		label.contentsScale = UIScreen.main.scale
		badge.addSublayer(label)
		
		// Save Badge as UIButtonItem property
		objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
	
	func updateBadge(number: Int) {
		if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
			text.string = "\(number)"
		}
	}
	
	func removeBadge() {
		badgeLayer?.removeFromSuperlayer()
	}
*/
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
