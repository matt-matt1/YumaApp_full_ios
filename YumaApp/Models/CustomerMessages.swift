//
//  CustomerMessages.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CustomerMessages: Codable
{
	let customer_messages: [CustomerMessage]?
}
struct CustomerMessage: Codable
{
	let id: 				Int?
	let id_employee: 		String?
	let id_customer_thread: String?
	let ip_address: 		String?
	let message: 			String?
	let file_name: 			String?
	let user_agent: 		String?
	let m_private: 			String?
	let date_add: 			String?
	let date_upd: 			String?
	let read: 				String?
}
