//
//  UIImageView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-08.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIImageView
{
	/// Returns the image with faded edges
	func fadeEdges(bounds_nilEqualsSelf_: CGRect?, shadowRadius: CGFloat=5, shadowOffset: CGSize=CGSize.zero, shadowColor: UIColor=UIColor.white, shadowOpacity: Float=1)
	{
		let layer = CAGradientLayer()
		layer.frame = (bounds_nilEqualsSelf_ != nil) ? bounds_nilEqualsSelf_! : self.bounds
		layer.shadowRadius = shadowRadius
		layer.shadowPath = CGPath(roundedRect: (bounds_nilEqualsSelf_ != nil) ? bounds_nilEqualsSelf_!.insetBy(dx: shadowRadius, dy: shadowRadius) : self.bounds.insetBy(dx: shadowRadius, dy: shadowRadius), cornerWidth: shadowRadius * 2, cornerHeight: shadowRadius * 2, transform: nil)
		layer.shadowOpacity = shadowOpacity
		layer.shadowOffset = shadowOffset
		layer.shadowColor = shadowColor.cgColor
		self.layer.mask = layer
	}

}
