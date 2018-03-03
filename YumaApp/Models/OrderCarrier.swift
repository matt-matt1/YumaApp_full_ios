//
//  OrderCarrier.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct OrderCarrier: Decodable
{
	let id: Int
	let id_order: String
	let id_carrier: String
	let id_order_invoice: String
	let weight: String
	let shipping_cost_tax_excl: String
	let shipping_cost_tax_incl: String
	let tracking_number: String
	let date_add: String
}
struct orderCarriers: Decodable
{
	let orderCarriers: [OrderCarrier]
}
