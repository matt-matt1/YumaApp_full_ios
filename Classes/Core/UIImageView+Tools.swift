//
//  UIImageView+Tools.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func aspectToFitFrame() -> CGRect {
		
		guard let image = image else {
			assertionFailure("No image found!")
			return CGRect.zero
		}
		
		let imageRatio: CGFloat = image.size.width / image.size.height
		let viewRatio: CGFloat = frame.size.width / frame.size.height
		
		if imageRatio < viewRatio {
			let scale: CGFloat = frame.size.height / image.size.height
			let width: CGFloat = scale * image.size.width
			let topLeftX: CGFloat = (frame.size.width - width) * 0.5
			return CGRect(x: topLeftX, y: 0, width: width, height: frame.size.height)
		} else {
			let scale: CGFloat = frame.size.width / image.size.width
			let height: CGFloat = scale * image.size.height
			let topLeftY: CGFloat = (frame.size.height - height) * 0.5
			return CGRect(x: 0, y: topLeftY, width: frame.size.width, height: height)
		}
	}
}
