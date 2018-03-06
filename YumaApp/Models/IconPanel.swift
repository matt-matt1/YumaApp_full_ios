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
	public var id: 		Int
	public var text: 	String
	public var icon: 	String
	public var target: 	String
	
	init(id: Int, text: String, icon: String, target: String)
	{
		self.id = 		id
		self.text = 	text
		self.icon = 	icon
		self.target = 	target
	}
}

