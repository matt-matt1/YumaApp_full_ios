//
//  Deliveries.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Deliveries: Codable
{
	let deliveries: [Delivery]?
}
struct Delivery: Codable
{
	let id: 				Int?
	let id_carrier: 		String?// xlink:href="http://yumatechnical.com/api/carriers/2">2</id_carrier>
	let id_range_price: 	String?
	let id_range_weight: 	String?// xlink:href="http://yumatechnical.com/api/weight_ranges/1">1</id_range_weight>
	let id_zone: 			String?// xlink:href="http://yumatechnical.com/api/zones/1">1</id_zone>
	let id_shop: 			String?
	let id_shop_group: 		String?
	let price: 				String?
}
