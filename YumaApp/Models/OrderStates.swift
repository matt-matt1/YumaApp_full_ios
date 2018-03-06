//
//  OrderStates.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderState: Decodable
{
	let id: 			Int?//!
	let unremovable: 	String?//Bool
	let delivery: 		String?//Bool
	let hidden: 		String?//Bool
	let send_email: 	String?//Bool
	let module_name: 	String?//object
	let invoice: 		String?//Bool
	let color: 			String?
	let logable: 		String?//Bool
	let shipped: 		String?//Bool
	let paid: 			String?//Bool
	let pdf_delivery: 	String?//Bool
	let pdf_invoice: 	String?//Bool
	let deleted: 		String?//Bool
	let name: 			[IdValue]?//!..64
	let template: 		[IdValue]?//..64
}
struct OrderStates: Decodable
{
	let order_states: [OrderState]?
}
