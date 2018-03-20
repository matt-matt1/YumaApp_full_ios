//
//  IdValue.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct IdValue: Codable
{
	let id: 	String?
	let value: 	String?
	
//	init(id: String, value: String)
//	{
//		self.id = id
//		self.value = value
//	}
}

public struct IdAsString: Codable
{
	let id: String?
}
