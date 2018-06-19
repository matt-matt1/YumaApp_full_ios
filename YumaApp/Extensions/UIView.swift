//
//  UIView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIView
{
	//https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
	// In order to create computed properties for extensions, we need a key to
	// store and access the stored property
	fileprivate struct AssociatedObjectKeys {
		static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
	}
	
	fileprivate typealias Action = (() -> Void)?
	
	// Set our computed property type to a closure
	fileprivate var tapGestureRecognizerAction: Action? {
		set {
			if let newValue = newValue {
				// Computed properties get stored as associated objects
				objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
			}
		}
		get {
			let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
			return tapGestureRecognizerActionInstance
		}
	}
	
	// This is the meat of the sauce, here we create the tap gesture recognizer and
	// store the closure the user passed to us in the associated object we declared above
	public func addTapGestureRecognizer(action: (() -> Void)?) {
		self.isUserInteractionEnabled = true
		self.tapGestureRecognizerAction = action
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		self.addGestureRecognizer(tapGestureRecognizer)
	}
	
	// Every time the user taps on the UIImageView, this function gets called,
	// which triggers the closure we stored
	@objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
		if let action = self.tapGestureRecognizerAction {
			action?()
		} else {
			print("no action")
		}
	}
	//
	//eg. sampleImageView.addTapGestureRecognizer {
	//	print("image tapped")
	//}
	//
	/////////////////////////////////
	func autoPinEdgesToSuperviewEdges(with: UIEdgeInsets)
	{
		addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 0, constant: with.top))
		addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 0, constant: with.left))
		addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 0, constant: with.bottom))
		addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 0, constant: with.right))
	}
	/// Assign a constraint to one or many views with nil metrics and default options
	func addConstraintsWithFormat(format: String, views: UIView...)
	{
		var viewsDict = [String : UIView]()
		for (ind, view) in views.enumerated()
		{
			let key = "v\(ind)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDict[key] = view
		}
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
	}
	//https://stackoverflow.com/questions/32301336/swift-recursively-cycle-through-all-subviews-to-find-a-specific-class-and-appen
	class func getAllSubviews<T: UIView>(view: UIView) -> [T] {
		return view.subviews.flatMap { subView -> [T] in
			var result = getAllSubviews(view: subView) as [T]
			if let view = subView as? T {
				result.append(view)
			}
			return result
		}
	}
	
	func getAllSubviews<T: UIView>() -> [T] {
		return UIView.getAllSubviews(view: self) as [T]
	}
	
	var safeTopAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.topAnchor
		} else {
			return self.topAnchor
		}
	}
	
	//	var safeLeftAnchor: NSLayoutXAxisAnchor {
	//		if #available(iOS 11.0, *){
	//			return self.safeAreaLayoutGuide.leftAnchor
	//		}else {
	//			return self.leftAnchor
	//		}
	//	}
	//
	//	var safeRightAnchor: NSLayoutXAxisAnchor {
	//		if #available(iOS 11.0, *){
	//			return self.safeAreaLayoutGuide.rightAnchor
	//		}else {
	//			return self.rightAnchor
	//		}
	//	}
	
	var safeLeadingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.leadingAnchor
		}else {
			return self.leadingAnchor
		}
	}
	
	var safeTrailingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.trailingAnchor
		}else {
			return self.trailingAnchor
		}
	}
	
	var safeBottomAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.bottomAnchor
		} else {
			return self.bottomAnchor
		}
	}
	//	var recursiveSubviews: [UIView]
	//	{
	//		var subviews = self.subviews.flatMap({$0})
	//		subviews.forEach { 	subviews.append(contentsOf: $0.recursiveSubviews) 	}
	//		return subviews
	//	}
	//	func searchVisualEffectsSubview() -> UIVisualEffectView?
	//	{
	//		if let visualEffectView = self as? UIVisualEffectView
	//		{
	//			return visualEffectView
	//		}
	//		else
	//		{
	//			for subview in subviews
	//			{
	//				if let found = subview.searchVisualEffectsSubview()
	//				{
	//					return found
	//				}
	//			}
	//		}
	//		return nil
	//	}
	/// Round only specific corners. Eg. someView.round(corners: [.topLeft, .topRight], radius: 5)
	func justRound(corners: UIRectCorner, radius: CGFloat)
	{
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
	
	/// Dupicale an entire view
	func copyView<T: UIView>() -> T
	{
		return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
	}
	
	/// Applies an animation for a specific duration of time
	func animateConstraintWithDuration(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [], completion: ((Bool) -> Void)? = nil)
	{
		UIView.animate(withDuration: duration, delay:delay, options:options, animations:
			{
				[weak self] in
				self?.layoutIfNeeded() ?? ()
			}, completion: completion)
	}
	
	/// Applies a range of colors (that merge) to the background
	func addBackgroundGradient(colors c:[CGColor], isVertical: Bool = true) -> CAGradientLayer
	{
		self.layer.sublayers = self.layer.sublayers?.filter() { 	!($0 is CAGradientLayer) 	}
		let layer : CAGradientLayer = CAGradientLayer()
		layer.frame.size = self.frame.size
		layer.frame.origin = CGPoint(x: 0, y: 0)
		layer.colors = c
		if isVertical
		{
			layer.startPoint = CGPoint(x:0.5, y:0.0)
			layer.endPoint = CGPoint(x:0.5, y:1.0)
		}
		else
		{
			layer.startPoint = CGPoint(x:0.0, y:0.5)
			layer.endPoint = CGPoint(x:1.0, y:0.5)
		}
		if self.cornerRadius > 0
		{
			layer.cornerRadius = self.cornerRadius
		}
		self.layer.insertSublayer(layer, at: 0)
		return layer
	}
	
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable
	var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable
	var borderColor: UIColor? {
		get {
			if let color = layer.borderColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				layer.borderColor = color.cgColor
			} else {
				layer.borderColor = nil
			}
		}
	}
	
	@IBInspectable
	var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set {
			layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable
	var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set {
			layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable
	var shadowOffset: CGSize {
		get {
			return layer.shadowOffset
		}
		set {
			layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable
	var shadowColor: UIColor? {
		get {
			if let color = layer.shadowColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				layer.shadowColor = color.cgColor
			} else {
				layer.shadowColor = nil
			}
		}
	}
}
