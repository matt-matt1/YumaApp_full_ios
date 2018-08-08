//
//  UIBarButtonItem+Badge.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-07.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//
//  you need to reference the button in a variable and add the method on that...
//
//	navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(lockedButton))
//
//	let rightBarButtons = self.navigationItem.rightBarButtonItems
//
//	let lastBarButton = rightBarButtons?.last
//
//	lastBarButton?.addBadge(number: 4)
//
//let bellButton = UIButton(type: .custom)
//bellButton.setBackgroundImage(UIImage(named:"notification"), for: .normal)
//bellButton.addTarget(self, action: #selector(didClickNotificationButton(_:)), for: .touchUpInside)
//
//let notificationBarButton = UIBarButtonItem(customView: bellButton)
//
//Note: Offset needs to be adjusted as required when adding a badge.

//if you put the code of addBadge inside viewDidLayoutSubviews() it will work fine with orientation
//So if you want to display the badge, you would have to set the badge outside of viewDidLoad and you should see the badge. It seems setting the badge in viewDidAppear works for me there.
//
//If you have been setting the badge in viewDidLoad, in iOS11 it handles it differently. Any related UI work will break or wont work. Try setting the badge outside of viewDidLoad and see if that works.
//
//	https://gist.github.com/freedom27/c709923b163e26405f62b799437243f4
//

import UIKit


//private struct AssociatedKey {
//	static var badgeLayer = "badgeLayer"
//}
//
//fileprivate var badgeLayer: CAShapeLayer? {
//	get {
//		return objc_getAssociatedObject(self, &AssociatedKey.badgeLayer) as? CAShapeLayer
//	}
//	set {
//		if let newValue = newValue {
//			objc_setAssociatedObject(
//				self,
//				&AssociatedKey.badgeLayer,
//				newValue as CAShapeLayer?,
//				.OBJC_ASSOCIATION_RETAIN_NONATOMIC
//			)
//		}
//	}
//}


extension CAShapeLayer
{
	/// Draws a rounded-rectangle with an ouline of backgroundColor and filled with either the backgroundColor or white
	func drawRoundedRect(rect: CGRect, backgroundColor color: UIColor, filled: Bool, fontSize: CGFloat)
	{
		fillColor = filled ? color.cgColor : UIColor.white.cgColor
		strokeColor = color.cgColor
		path = UIBezierPath(roundedRect: rect, cornerRadius: fontSize/3/*7*/).cgPath
	}
	
}

private var handle: UInt8 = 0

extension UIBarButtonItem
{
	private var badgeLayer: CAShapeLayer?
	{
		if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject?
		{
			return b as? CAShapeLayer
		}
		else
		{
			return nil
		}
	}
	
	/// Inserts a badge onto a UIBarButtonItem, containing text at offset in textColor and backgroundColor with fontSize
	func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint=CGPoint.zero, textColor: UIColor=UIColor.white, backgroundColor color: UIColor=UIColor.red, backgroundFilled filled: Bool=true, textFontSize fontSize: CGFloat=11)
	{
		badgeLayer?.removeFromSuperlayer()
		if text == nil || text == ""
		{
			return
		}
		addBadge(text: text!, withOffset: offset, textColor: textColor, backgroundColor: color, backgroundFilled: filled, textFontSize: fontSize)
	}
	
	private func addBadge(text: String, withOffset offset: CGPoint, textColor: UIColor, backgroundColor color: UIColor, backgroundFilled filled: Bool, textFontSize fontSize: CGFloat)
	{
		guard let view = self.value(forKey: "view") as? UIView 	else 	{ 	return 	}
		guard view.frame.width > 0 	else 	{ 	return 	}
		var font = UIFont.systemFont(ofSize: fontSize)
		if #available(iOS 9.0, *)
		{
			font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
		}
		let badgeSize = text.size(withAttributes: [NSAttributedStringKey.font: font])
		
		//initialize Badge
		let badge = CAShapeLayer()
		let height = badgeSize.height;
		var width = badgeSize.width + 2 /* padding */
		
		//make sure we have at least a circle
		if (width < height)
		{
			width = height
		}
		
		//x position is offset from right-hand side
		let x = (view.frame.width > 0) ? view.frame.width - width + offset.x : offset.x
		let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
		badge.drawRoundedRect(rect: badgeFrame, backgroundColor: color, filled: filled, fontSize: fontSize)
		view.layer.addSublayer(badge)
		
		//initialiaze Badge's label
		let label = CATextLayer()
		label.string = text
		label.alignmentMode = kCAAlignmentCenter
		label.font = font
		label.fontSize = font.pointSize
		label.frame = badgeFrame
		label.foregroundColor = filled ? textColor/*UIColor.white*/.cgColor : color.cgColor
		label.backgroundColor = UIColor.clear.cgColor
		label.contentsScale = UIScreen.main.scale
		badge.addSublayer(label)
		
		//save Badge as UIBarButtonItem property
		objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		
		//bring layer to front
		badge.zPosition = 1000
	}
	
	private func removeBadge()
	{
		badgeLayer?.removeFromSuperlayer()
	}

}
