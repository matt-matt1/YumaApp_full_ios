//
//  Slides.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

public class Slide {
	public var id: Int
	public var image: String
	public var caption1: String
	public var caption2: String
	public var target: String
	public var width: Int
	public var height: Int
	//public func callMethodDirectly() {}
	
	init(id: Int, image: String, caption1: String, caption2: String, target: String, width: Int, height: Int/*, callMethodDirectly: CGFunction*/) {
		self.id = id
		self.image = image
		self.caption1 = caption1
		self.caption2 = caption2
		self.target = target
		self.width = width
		self.height = height
		//self.callMethodDirectly = callMethodDirectly
	}
}

