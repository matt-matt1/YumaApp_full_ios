//
//  Shops.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Shops: Codable
{
	let shops: [Shop]?
}
struct Shop: Codable
{
	let id: 			Int?
	let id_shop_group: 	String?
	let id_category: 	String?
	let active: 		String?
	let deleted: 		String?
	let name: 			String?
	let theme_name: 	String?
}
