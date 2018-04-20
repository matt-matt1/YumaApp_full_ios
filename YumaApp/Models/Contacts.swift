//
//  Contacts.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Contacts: Codable
{
	let contacts: [Contact]?
}
struct Contact: Codable
{
	let id: 				Int?
	let email: 				String?
	let customer_service: 	String?
	let name: 				[IdValue]?
	let description: 		[IdValue]?
}
