//
//  OrderHistory.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderHistory: Decodable
{
	let id: 				Int?//!
	let id_employee: 		String?
	let id_order_state: 	String?//!
	let id_order: 			String?//!
	let date_app: 			String?//date
}
struct OrderHistories: Decodable
{
	let order_histories: [OrderHistory]?
}
