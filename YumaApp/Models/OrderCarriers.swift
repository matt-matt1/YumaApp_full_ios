//
//  OrderCarrier.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderCarrier: Codable
{
	let id: 					Int?//!
	let id_order: 				String?//!
	let id_carrier: 			String?//!
	let id_order_invoice: 		String?
	let weight: 				String?//Float
	let shipping_cost_tax_excl: String?//Float
	let shipping_cost_tax_incl: String?//Float
	let tracking_number: 		String?
	let date_add: 				String?//date
}
struct OrderCarriers: Codable
{
	let order_carriers: [OrderCarrier]?
}
