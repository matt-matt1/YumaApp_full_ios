//
//  UIApplication.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UIApplication
{
	static let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
	//	if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
	//	{
	//		statusbar.backgroundColor = UIColor.clear
	//	}
}
