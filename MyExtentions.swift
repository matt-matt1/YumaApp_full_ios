//
//  MyExtentions.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UINavigationBar
{
	/// Applies a background gradient with the given colors
	//
	//eg.
	//navigationController?.navigationBar.applyNavigationGradient(colors: [UIColor.red , UIColor.yellow])
	//
	func applyNavigationGradient(colors: [UIColor], isVertical: Bool = true)
	{
		var frameAndStatusBar: CGRect = self.bounds
		frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
		
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


///////////////////////////////////////////////////////////
extension UIView
{
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


///////////////////////////////////////////////////////////
extension CALayer
{
	/// Applies a range of colors (that merge) to the view's border
	func addGradienBorder(colors:[UIColor] = [UIColor.red,UIColor.blue], width: CGFloat = 1, isVertical: Bool)
	{
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
		if isVertical
		{
			gradientLayer.startPoint = CGPoint(x:0.5, y:0.0)
			gradientLayer.endPoint = CGPoint(x:0.5, y:1.0)
		}
		else
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
			gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
		}
		if self.cornerRadius > 0
		{
			gradientLayer.cornerRadius = self.cornerRadius
		}
		gradientLayer.colors = colors.map({$0.cgColor})
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.lineWidth = width
		shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = UIColor.black.cgColor
		gradientLayer.mask = shapeLayer
		
		self.addSublayer(gradientLayer)
	}

	/// Applies a range of colors (that merge) to the background
	func addBackgroundGradient(colors:[UIColor] = [UIColor.red,UIColor.blue], width: CGFloat = 1, isVertical: Bool)
	{
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
		if isVertical
		{
			gradientLayer.startPoint = CGPoint(x:0.5, y:0.0)
			gradientLayer.endPoint = CGPoint(x:0.5, y:1.0)
		}
		else
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
			gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
		}
		if self.cornerRadius > 0
		{
			gradientLayer.cornerRadius = self.cornerRadius
		}
		gradientLayer.colors = colors.map(	{ 	$0.cgColor 	}	)
		
		self.addSublayer(gradientLayer)
	}
}


///////////////////////////////////////////////////////////
extension UIViewController
{
	/// Applies a spinner over the display
	class func displaySpinner(onView : UIView) -> UIView
	{
		let spinnerView = UIView.init(frame: onView.bounds)
		spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
		ai.startAnimating()
		ai.center = spinnerView.center
		
		DispatchQueue.main.async
			{
				spinnerView.addSubview(ai)
				onView.addSubview(spinnerView)
			}
		
		return spinnerView
	}
	
	/// Removes the named spinner from the display
	class func removeSpinner(spinner :UIView)
	{
		DispatchQueue.main.async
			{
				spinner.removeFromSuperview()
			}
	}
}


///////////////////////////////////////////////////////////
public extension KeyedDecodingContainer
{
	//http://kean.github.io/post/codable-tips-and-tricks
//	public func decodeSafely<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
//		return self.decodeSafely(T.self, forKey: key)
//	}
//
//	public func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
//		let decoded = try? decode(FailableDecodable<T>.self, forKey: key)
//		return decoded?.value
//	}
//
//	public func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
//		return self.decodeSafelyIfPresent(T.self, forKey: key)
//	}
//
//	public func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
//		let decoded = try? decodeIfPresent(FailableDecodable<T>.self, forKey: key)
//		return decoded??.value
//	}
//	public func decodeSafelyArray<T: Decodable>(of type: T.Type, forKey key: KeyedDecodingContainer.Key) -> [T] {
//		let array = decodeSafely([FailableDecodable<T>].self, forKey: key)
//		return array?.flatMap { $0.raw } ?? []
//	}
	/// Returns an Int
	public func decode(_ type: Int.Type, forKey key: Key) throws -> Int
	{
		let stringValue = try self.decode(String.self, forKey: key)
		guard let floatValue = Int(stringValue) else
		{
			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Int")
			throw DecodingError.dataCorrupted(context)
		}
		return floatValue
	}
}


///////////////////////////////////////////////////////////
extension String
{
	/// Ramdom alphanumberic string
	var randomLetters: String
	{
		get
		{
			let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
			let len = 20 // length
			let randomString : NSMutableString = NSMutableString(capacity: len)
			
			for _ in 0 ..< len
			{
				let length = UInt32 (letters.length)
				let rand = arc4random_uniform(length)
				randomString.appendFormat("%C", letters.character(at: Int(rand)))
			}
			return randomString as String
		}
	}
	/// Ramdom alphanumberic string
	var randomLettersAndSymbols: String
	{
		get
		{
			let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()~;,./<>?:-_[]{}=+\\|"
			let len = 20 // length
			let randomString : NSMutableString = NSMutableString(capacity: len)
			
			for _ in 0 ..< len
			{
				let length = UInt32 (letters.length)
				let rand = arc4random_uniform(length)
				randomString.appendFormat("%C", letters.character(at: Int(rand)))
			}
			return randomString as String
		}
	}
	/// Returns the index (Int) of character in a String
	func indexOf(_ character: Character) -> Int
	{
		return (index(of: character)?.encodedOffset)!
	}
	/// Returns the index (Int) of character in a String, reverse order
	func lastIndexOf(_ character: String) -> Int?
	{
		guard let index = range(of: character, options: .backwards) else { 	return nil 	}
		return self.distance(from: self.startIndex, to: index.lowerBound)
	}
	/// Returns the sub-String located between the given characters within a String
	func substringBetween(_ fromCharacter: Character, _ toChartacter: String, exclusive: Bool = false) -> String
	{
		var pos1 = self.indexOf("[")
		var pos2 = self.lastIndexOf("]")!+1
		if exclusive
		{
			pos1 += 1
			pos2 -= 1
		}
		let start = self.index(self.startIndex, offsetBy: pos1)
		let end = self.index(self.startIndex, offsetBy: pos2)
		return String(self[start..<end])
	}
	
	///findArrayPositionOf(findValue: AnyObject, inArray: [AnyObject], searchElements: AnyObject) -> Int
	func findArrayPositionOf(findValue: AnyObject, inArray: [AnyObject], searchElements: AnyObject) -> Int
	{
		var i: Int = 0;
		var found: Int = -1
		for obj in inArray
		{
			//			let pair = obj as! Dictionary
			//			for element in pair
			//			{
			//				if pair.key == findValue
			//			}
			if obj.elementType == searchElements.elementType //&& obj.element(searchElements) == findValue
			{
				found = i//return i
			}
			i+=1
		}
		return found
	}

	/// Converts a String to a double value
	func toDouble() -> Double?
	{
		return NumberFormatter().number(from: self)?.doubleValue
	}
}


///////////////////////////////////////////////////////////
extension UIImage
{
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


///////////////////////////////////////////////////////////
extension URLResponse
{
	/// Return the status code in a URL response
	func getStatusCode() -> Int?
	{
		if let httpResponse = self as? HTTPURLResponse
		{
			return httpResponse.statusCode
		}
		return nil
	}
}


///////////////////////////////////////////////////////////
extension Dictionary where Key: ExpressibleByStringLiteral
{
	subscript<Index: RawRepresentable>(index: Index) -> Value? where Index.RawValue == String
	{
		get {	return self[index.rawValue as! Key]			}
		set {	self[index.rawValue as! Key] = newValue		}
	}
}


///////////////////////////////////////////////////////////
extension UIColor
{
	/// A color object whose RGB values are 0.1, 0.5, and 0.9 and whose alpha value is 1.
	static let blueApple = UIColor(red: 0.1520819664, green: 0.5279997587, blue: 0.985317409, alpha: 1)
}



///////////////////////////////////////////////////////////
extension UILabel
{
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
