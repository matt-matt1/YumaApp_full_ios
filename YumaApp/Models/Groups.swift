//
//  Groups.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Groups: Codable//The customer's groups
{
	let groups: [Group]?
}
struct Group: Codable
{
	let id: 					Int?
	let reduction: 				String?
	let price_display_method: 	String?
	let show_prices: 			String?
	let date_add: 				String?
	let date_upd: 				String?
	let name: 					IdValue?
}
