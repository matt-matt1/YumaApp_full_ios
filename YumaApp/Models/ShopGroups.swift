//
//  ShopGroups.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ShopGroups: Codable
{
	let shop_groups: [ShopGroup]
}
struct ShopGroup: Codable
{
	let id: 			Int?
	let name: 			String?
	let share_customer: String?
	let share_order: 	String?
	let share_stock: 	String?
	let active: 		String?
	let deleted: 		String?
}
