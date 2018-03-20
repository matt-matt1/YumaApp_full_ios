//
//  Tax.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Tax: Decodable
{
	let id: 		Int?//!
	let rate: 		String?//!Float
	let active: 	String?
	let deleted: 	String?
	let name: 		[IdValue]?
}
struct Taxes: Decodable
{
	let taxes: [Tax]?
}
