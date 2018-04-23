//
//  CartRules.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation

struct CartRules: Codable
{
	let cart_rules: [CartRule]?
}
struct CartRule: Codable
{
	let id_customer: 				String?//format="isUnsignedId"/>
	let date_from: 					String?//required="true" format="isDate"/>
	let date_to: 					String?//required="true" format="isDate"/>
	let description: 				String?//maxSize="65534" format="isCleanHtml"/>
	let quantity: 					String?//format="isUnsignedInt"/>
	let quantity_per_user: 			String?//format="isUnsignedInt"/>
	let priority: 					String?//format="isUnsignedInt"/>
	let partial_use: 				String?//format="isBool"/>
	let code: 						String?//maxSize="254" format="isCleanHtml"/>
	let minimum_amount: 			String?//format="isFloat"/>
	let minimum_amount_tax: 		String?//format="isBool"/>
	let minimum_amount_currency: 	String?//format="isInt"/>
	let minimum_amount_shipping: 	String?//format="isBool"/>
	let country_restriction: 		String?//format="isBool"/>
	let carrier_restriction: 		String?//format="isBool"/>
	let group_restriction: 			String?//format="isBool"/>
	let cart_rule_restriction: 		String?//format="isBool"/>
	let product_restriction: 		String?//format="isBool"/>
	let shop_restriction: 			String?//format="isBool"/>
	let free_shipping: 				String?//format="isBool"/>
	let reduction_percent: 			String?//format="isPercentage"/>
	let reduction_amount: 			String?//format="isFloat"/>
	let reduction_tax: 				String?//format="isBool"/>
	let reduction_currency: 		String?//format="isUnsignedId"/>
	let reduction_product: 			String?//format="isInt"/>
	let reduction_exclude_special: 	String?//format="isBool"/>
	let gift_product: 				String?//format="isUnsignedId"/>
	let gift_product_attribute: 	String?//format="isUnsignedId"/>
	let highlight: 					String?//format="isBool"/>
	let active: 					String?//format="isBool"/>
	let date_add: 					String?//format="isDate"/>
	let date_upd: 					String?//format="isDate"/>
	let name: 						IdValue?//required="true" maxSize="254" format="isCleanHtml">
	//		<language id="1" xlink:href="http://yumatechnical.com/api/languages/1" format="isUnsignedId"/>
	//		<language id="2" xlink:href="http://yumatechnical.com/api/languages/2" format="isUnsignedId"/>
}
