//
//  GradientButton.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-11.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


@IBDesignable
class GradientButton: UIButton
{
	let gradientLayer = CAGradientLayer()
	
	@IBInspectable
	var topGradientColor: UIColor?
	{
		didSet
		{
			setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
		}
	}
	
	@IBInspectable
	var bottomGradientColor: UIColor?
	{
		didSet
		{
			setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
		}
	}
	
	private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?)
	{
		if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor
		{
			gradientLayer.frame = bounds
			gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
			gradientLayer.borderColor = layer.borderColor
			gradientLayer.borderWidth = layer.borderWidth
			gradientLayer.cornerRadius = layer.cornerRadius
			layer.insertSublayer(gradientLayer, at: 0)
		}
		else
		{
			gradientLayer.removeFromSuperlayer()
		}
	}
	
	
	//	let gradientBorderLayer = CAGradientLayer()
	//
	//	@IBInspectable
	//	var topGradientBorderColor: UIColor?
	//	{
	//		didSet
	//		{
	//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
	//		}
	//	}
	//
	//	@IBInspectable
	//	var bottomGradientBorderColor: UIColor?
	//	{
	//		didSet
	//		{
	//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
	//		}
	//	}
	//
	//	@IBInspectable
	//	var gradientBorderWidth: CGFloat
	//	{
	//		didSet
	//		{
	//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
	//		}
	//	}
	//
	//
	//	func addGradienBorder(topGradientBorderColor: UIColor?, bottomGradientBorderColor: UIColor?, width: CGFloat)
	//	{
	//		if let topGradientBorderColor = topGradientBorderColor, let bottomGradientBorderColor = bottomGradientBorderColor
	//		{
	//			gradientBorderLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
	//			gradientBorderLayer.startPoint = CGPoint(x:0.0, y:0.5)
	//			gradientBorderLayer.endPoint = CGPoint(x:1.0, y:0.5)
	//			gradientBorderLayer.colors = [topGradientBorderColor.cgColor, bottomGradientBorderColor.cgColor]
	//
	//			let shapeLayer = CAShapeLayer()
	//			shapeLayer.lineWidth = width
	//			shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
	//			shapeLayer.fillColor = nil
	//			shapeLayer.strokeColor = UIColor.black.cgColor
	//			gradientBorderLayer.mask = shapeLayer
	//
	//			layer.addSublayer(gradientLayer)
	//		}
	//	}
}

