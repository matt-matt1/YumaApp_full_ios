//
//  SpecificPrices.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct SpecificPrices: Codable
{
	let specific_prices: [SpecificPrice]?
}
struct SpecificPrice: Codable
{
	let id: 					Int?
	let id_shop_group: 			String?
	let id_shop: 				String?
	let id_cart: 				String?
	let id_product: 			String?
	let id_product_attribute: 	String?
	let id_currency: 			String?
	let id_country: 			String?
	let id_group: 				String?
	let id_customer: 			String?
	let id_specific_price_rule: String?
	let price: 					String?
	let from_quantity: 			String?
	let reduction: 				String?
	let reduction_tax: 			String?
	let reduction_type: 		String?
	let from: 					String?
	let to: 					String?
}
