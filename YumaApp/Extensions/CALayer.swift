//
//  CALayer.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


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
	func addBackgroundGradient(colors:[UIColor] = [UIColor.red,UIColor.blue], isVertical: Bool)
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
