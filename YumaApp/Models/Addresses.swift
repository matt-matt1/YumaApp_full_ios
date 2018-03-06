//
//  AddressesJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Address: Decodable
{
	let id: 				Int?
	let id_customer: 		String?
	let id_manufacturer: 	String?
	let id_supplier: 		String?
	let id_warehouse: 		String?
	let id_country: 		String
	let id_state: 			String?
	let alias: 				String//..32
	let company: 			String?//..255
	let lastname: 			String//..32
	let firstname: 			String//..32
	let vat_number: 		String?
	let address1: 			String//..128
	let address2: 			String?//..128
	let postcode: 			String?//..12
	let city: 				String//..64
	let other: 				String?//..300
	let phone: 				String?//..32
	let phone_mobile: 		String?//..32
	let dni: 				String?//..16
	let deleted: 			String?//Bool
	let date_add: 			String?//date
	let date_upd: 			String?//date
}
struct Addresses: Decodable
{
	let addresses: [Address]?
}
