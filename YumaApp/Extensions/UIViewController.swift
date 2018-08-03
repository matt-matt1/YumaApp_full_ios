//
//  UIViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIViewController
{
	/// Applies a spinner over the display
	class func displaySpinner(onView : UIView) -> UIView
	{
		let spinnerView = UIView.init(frame: onView.bounds)
		spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
		ai.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
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

