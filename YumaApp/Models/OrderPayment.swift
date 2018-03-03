//
//  OrderPayment.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderPayment: Decodable
{
	let id: String
	let order_reference: String
	let id_currency: String
	let amount: String
	let payment_method: String
	let conversion_rate: String
	let transaction_id: String
	let card_number: String
	let card_brand: String
	let card_expiration: String
	let card_holder: String
	let date_add: String
}
struct OrderPayments: Decodable
{
	let orderPayments: [OrderPayment]
}
