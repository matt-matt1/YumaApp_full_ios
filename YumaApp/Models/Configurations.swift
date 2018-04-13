//
//  Configurations.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Configuration: Decodable
{
	let id:				Int?
	let value:			String?
	let name:			String?
	let id_shop_group: 	String?
	let id_shop:		String?
	let date_add: 		String?
	let date_upd: 		String?
}
struct Configurations: Decodable
{
	let configurations: [Configuration]?
}
