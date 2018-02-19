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
	let id: Int?
	let id_customer: String?
	let id_manufacturer: String?
	let id_supplier: String?
	let id_warehouse: String?
	let id_country: String?
	let id_state: String?
	let alias: String?
	let company: String?
	let lastname: String?
	let firstname: String?
	let vat_number: String?
	let address1: String
	let address2: String?
	let postcode: String?
	let city: String?
	let other: String?
	let phone: String?
	let phone_mobile: String?
	let dni: String?
	let deleted: String?
	let date_add: String?
	let date_upd: String?
}

struct Addresses: Decodable
{
	let addresses: [Address]
}
