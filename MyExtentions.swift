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
		
		setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors, isVertical: isVertical), for: .default)
	}
	
	/// Creates a gradient image with the given settings
	static func gradient(size : CGSize, colors : [UIColor], isVertical: Bool) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		if isVertical
		{
			context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0, y: size.height), options: [])
		}
		else
		{
			context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
		}
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}


extension UIView
{
	func addBackgroundGradient(colors c:[CGColor])->CAGradientLayer
	{
		self.layer.sublayers = self.layer.sublayers?.filter(){!($0 is CAGradientLayer)}
		let layer : CAGradientLayer = CAGradientLayer()
		layer.frame.size = self.frame.size
		layer.frame.origin = CGPoint(x: 0, y: 0)
		layer.colors = c
		self.layer.insertSublayer(layer, at: 0)
		return layer
	}
//	func layerGradient()
//	{
//		let layer : CAGradientLayer = CAGradientLayer()
//		layer.frame.size = self.frame.size
//		layer.frame.origin = CGPoint(x: 0, y: 0)
//		layer.cornerRadius = CGFloat(frame.width / 20)
//
//		let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
//		let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
//		let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
//		let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
//		let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
//		let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
//		let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
//
//		layer.colors = [color0,color1,color2,color3,color4,color5,color6]
//		self.layer.insertSublayer(layer, at: 0)
//	}
	
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


extension CALayer
{
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
		gradientLayer.colors = colors.map({$0.cgColor})
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.lineWidth = width
		shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = UIColor.black.cgColor
		gradientLayer.mask = shapeLayer
		
		self.addSublayer(gradientLayer)
	}
	
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
		gradientLayer.colors = colors.map({$0.cgColor})
		
		self.addSublayer(gradientLayer)
	}
}


extension UIViewController
{
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
	
	class func removeSpinner(spinner :UIView)
	{
		DispatchQueue.main.async
			{
				spinner.removeFromSuperview()
			}
	}
}
