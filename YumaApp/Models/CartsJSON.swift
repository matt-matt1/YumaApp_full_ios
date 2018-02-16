//
//  Carts.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct cart_rows
{
	var id_product: String
	var id_product_attribute: String
	var id_address_delivery: String
	var quantity: String
}
struct Carts
{
	var id: Int
	var id_address_delivery: String
	var id_address_invoice: String
	var id_currency: String
	var id_customer: String
	var id_guest: String
	var id_lang: String
	var id_shop_group: String
	var id_shop: String
	var id_carrier: String
	var recyclable: String
	var gift: String
	var gift_message: String
	var mobile_theme: String
	var delivery_option: String
	var secure_key: String
	var allow_seperated_package: String
	var date_add: String
	var date_upd: String
	var associations: NSDictionary
	var cart_rows: [cart_rows]
}
