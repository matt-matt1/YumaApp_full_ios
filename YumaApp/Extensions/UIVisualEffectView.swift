//
//  UIVisualEffectView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-11.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIVisualEffectView
{
	//https://stackoverflow.com/questions/29307827/how-to-fade-a-uivisualeffectview-and-or-uiblureffect-in-and-out
	func fadeInEffect(_ style:UIBlurEffectStyle = .light, withDuration duration: TimeInterval = 1.0)
	{
		if #available(iOS 10.0, *)
		{
			let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn)
			{
				self.effect = UIBlurEffect(style: style)
			}
			animator.startAnimation()
		}
		else
		{
			// Fallback on earlier versions
			UIView.animate(withDuration: duration)
			{
				self.effect = UIBlurEffect(style: style)
			}
		}
	}
	func fadeOutEffect(withDuration duration: TimeInterval = 1.0)
	{
		if #available(iOS 10.0, *)
		{
			let animator = UIViewPropertyAnimator(duration: duration, curve: .linear)
			{
				self.effect = nil
			}
			animator.startAnimation()
			animator.fractionComplete = 1
		}
		else
		{
			// Fallback on earlier versions
			UIView.animate(withDuration: duration)
			{
				self.effect = nil
			}
		}
	}
	
}
