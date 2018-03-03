//
//  Country.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct Country: Decodable
{
	let id: String
	let id_zone: String
	let id_currency: String
	let call_prefix: String
	let iso_code: String
	let active: String
	let contains_states: String
	let need_identification_number: String
	let need_zip_code: String
	let zip_code_format: String
	let display_tax_label: String
	let name: [IdValue]
}
