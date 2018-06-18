//
//  Attribute.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension R
{
	struct attribute
	{
		static let iconText: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			NSAttributedStringKey.font: UIFont(name: "FontAwesome", size: 42)!,
			//			NSAttributedStringKey.shadow: R.shadow.darkGray5_downright1
		]
		
		static let labelText: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			//NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
			NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 16)!
			//			NSAttributedStringKey.shadow: R.shadow.darkGray5_downright1
		]
		
		static let caption1: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaYel,
			NSAttributedStringKey.strokeColor: R.color.YumaRed,
			NSAttributedStringKey.strokeWidth: -4.0,
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 35),
			NSAttributedStringKey.shadow: R.shadow.darkGray3_downright1()
			//			NSAttributedStringKey.strokeColor: R.color.YumaRed,
			//			NSAttributedStringKey.strokeWidth: 3
		]
		
		static let caption2: [NSAttributedStringKey : Any] = [
			NSAttributedStringKey.foregroundColor: R.color.YumaRed,
			NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 18),
			//			NSAttributedStringKey.shadow: R.shadow.darkGray3_downright1()
			//			NSAttributedStringKey.strokeColor: R.color.YumaRed,
			//			NSAttributedStringKey.strokeWidth: 1
		]
	}

}
