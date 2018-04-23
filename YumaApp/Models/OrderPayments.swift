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
	let id: 				Int?//!
	let order_reference: 	String?//..9
	let id_currency: 		String?//!
	let amount: 			String?//!
	let payment_method: 	String?
	let conversion_rate: 	String?//Float
	let transaction_id: 	String?//..254
	let card_number: 		String?//..254
	let card_brand: 		String?//..254
	let card_expiration: 	String?//..254
	let card_holder: 		String?//..254
	let date_add: 			String?//date
}
struct OrderPayments: Decodable
{
	let orderPayments: [OrderPayment]?
}
