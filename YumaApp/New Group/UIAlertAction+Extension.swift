//
//  UIAlertAction+Extension.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

extension UIAlertController {
	func addAction(title: String, style: UIAlertActionStyle = .default, image: UIImage? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
		self.addAction(UIAlertAction(title: title, style: style, image: image, handler: handler))
	}
}

extension UIAlertAction {
	convenience init(title: String, style: UIAlertActionStyle = .default, image: UIImage?, handler: ((UIAlertAction) -> Void)? = nil) {
		self.init(title: title, style: style, handler: handler)
		if let image = image {
			self.accessoryImage = image
		}
	}
}
