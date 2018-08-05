//
//  R.font.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension R
{
	struct font
	{
		static let avenirNextBold16 = UIFont.init(name: "AvenirNext-Bold", size: 16)
		static let avenirNextBold14 = UIFont.init(name: "AvenirNext-Bold", size: 14)
		//static let fontAwesome = Rswift.FontResource(fontName: "FontAwesome")
		//static let fontAwesome = UIFont(name: "FontAwesome", size: )
		
		static func FontAwesomeOfSize(pointSize: Int) -> UIFont
		{
			return UIFont(name: "FontAwesome", size: CGFloat(pointSize))!
		}
		
		//static func fontAwesome(size: CGFloat) -> UIKit.UIFont? {
		//	return UIKit.UIFont(resource: fontAwesome, size: size)
		//}
		
		//static func validate() throws {
		//	if R.font.fontAwesome(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'FontAwesome' could not be loaded, is 'FontAwesome.ttf' added to the UIAppFonts array in this targets Info.plist?") }
		//}
	}

}
