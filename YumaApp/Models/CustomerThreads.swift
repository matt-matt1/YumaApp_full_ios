//
//  CustomerThreads.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CustomerThreads: Codable
{
	let customer_threads: [CustomerThread]?
}
struct CustomerThread: Codable
{
	let id: 			Int?
	let id_lang: 		String?
	let id_shop: 		String?
	let id_customer: 	String?
	let id_order: 		String?
	let id_product: 	String?
	let id_contact: 	String?
	let email: 			String?
	let token: 			String?
	let status: 		String?
	let date_add: 		String?
	let date_upd: 		String?
	let associations: 	[CustomerMessageAssociations]?
}
struct CustomerMessageAssociations: Codable
{
	let customer_messages: IdAsString?
}
