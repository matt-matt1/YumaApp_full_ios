//
//  R.shadow.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension R
{
	struct shadow
	{
		static func darkGray3_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 3
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = UIColor.gray
			return shadow
		}
		
		static func YumaRed5_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 5
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = R.color.YumaRed
			return shadow
		}
		
		static func darkGray1_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 1
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = UIColor.darkGray
			return shadow
		}
		
		static func darkGray5_downright1() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 5
			shadow.shadowOffset = CGSize(width: 1, height: 1)
			shadow.shadowColor = UIColor.gray
			return shadow
		}
		
		static func darkGray5_downright2() -> NSShadow
		{
			let shadow = NSShadow()
			shadow.shadowBlurRadius = 10
			shadow.shadowOffset = CGSize(width: 2, height: 2)
			shadow.shadowColor = UIColor.gray
			return shadow
		}
	}
}
