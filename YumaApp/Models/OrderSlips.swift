//
//  OrderSlips.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderSlips: Codable
{
	let order_slips: [OrderSlip]?
}
struct OrderSlip: Codable
{
	let id: 						Int?
	let id_customer: 				String?
	let id_order: 					String?
	let conversion_rate: 			String?
	let total_products_tax_excl: 	String?
	let total_products_tax_incl: 	String?
	let total_shipping_tax_excl: 	String?
	let total_shipping_tax_incl: 	String?
	let amount: 					String?
	let shipping_cost: 				String?
	let shipping_cost_amount: 		String?
	let partial: 					String?
	let date_add: 					String?
	let date_upd: 					String?
	let order_slip_type: 			String?
}
