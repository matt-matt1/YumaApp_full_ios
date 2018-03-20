//
//  ScoialMedia.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ScoialMedia
{
	let id: Int
	let name: [IdValue]
	let link: String?
	let thumb: String?
	
	init(id: Int, name: [IdValue], link: String? = nil, thumb: String? = nil)
	{
		self.id = id
		self.name = name
		self.link = link
		self.thumb = thumb
	}
}
