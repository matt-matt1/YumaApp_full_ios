//
//  SpecificPrices.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct SpecificPriceRules: Codable
{
	let specific_price_rules: [SpecificPriceRule]?
}
struct SpecificPriceRule: Codable
{
	let id: 			Int?
	let id_shop: 		String?
	let id_country: 	String?
	let id_currency: 	String?
	let id_group: 		String?
	let name: 			String?
	let from_quantity: 	String?
	let price: 			String?
	let reduction: 		String?
	let reduction_tax: 	String?
	let reduction_type: String?
	let from: 			String?
	let to: 			String?
}
