//
//  Message.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Messages: Codable
{
	let messages: [Message]?
}
struct Message: Codable
{
	let id: 			String?//!
	let id_cart: 		String?
	let id_order: 		String?
	let id_customer: 	String?
	let id_employee: 	String?
	let message: 		String?//!..1600 html
	let isprivate: 		String?//Bool
	let date_add: 		String?//date
}
