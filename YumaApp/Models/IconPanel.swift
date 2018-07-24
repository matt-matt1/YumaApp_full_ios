//
//  IconPanel.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

public class IconPanel
{
	public var id: 					Int
	public var text: 				String
	public var icon: 				String?
	public var iconAttr: 			NSAttributedString?
	public var menuPos: 			Int?
	public var trailingSeparator: 	Bool?
	public var target: 				Selector?
	public var canFade: 			Bool
	public var canAction: 			Bool
	
	init(id: Int, text: String, icon: String?=nil, iconAttr: NSAttributedString?=nil, menuPos: Int?=nil, trailingSeparator: Bool?=nil, target: Selector?, canFade: Bool, canAction: Bool)
	{
		self.id = 					id
		self.text = 				text
		self.icon = 				icon
		self.iconAttr = 			iconAttr
		self.menuPos = 				menuPos
		self.trailingSeparator = 	trailingSeparator
		self.target = 				target
		self.canFade = 				canFade
		self.canAction = 			canAction
	}
}

