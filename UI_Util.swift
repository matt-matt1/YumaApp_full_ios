//
//  header.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class UI_Util {
	
	static func setGradientGreenBlue(uiView: UIView) {
		
		let colorTop =  UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
		let colorBottom = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [ colorTop, colorBottom]
		gradientLayer.locations = [ 0.0, 1.0]
		gradientLayer.frame = uiView.bounds
		
		uiView.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	static func setGradientBlackRed(uiView: UIView) {
		
		let colorTop =  UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 0.0).cgColor
		let colorBottom = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [ colorTop, colorBottom]
		gradientLayer.locations = [ 0.0, 1.0]
		gradientLayer.frame = uiView.bounds
		
		uiView.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	static func setGradientDRedTransparent(uiView: UIView) {
		
		let colorTop =  UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
		let colorBottom = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [ colorTop, colorBottom]
		gradientLayer.locations = [ 0.0, 1.0]
		gradientLayer.frame = uiView.bounds
		
		uiView.layer.insertSublayer(gradientLayer, at: 0)
	}
}
