//
//  countries.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

struct Countries {
	public var id: Int
	public var id_zone: String
	public var id_currency: String
	public var call_prefix: String
	public var iso_code: String
	public var active: String
	public var contains_states: String
	public var need_identification_number: String
	public var need_zip_code: String
	public var zip_code_format: String
	public var display_tax_label: String
	public var name: Names_Countries
	
//	init(id: Int,
//		id_zone: String,
//		id_currency: String,
//		call_prefix: String,
//		iso_code: String,
//		active: String,
//		contains_states: String,
//		need_identification_number: String,
//		need_zip_code: String,
//		zip_code_format: String,
//		display_tax_label: String,
//		name: Names_Countries) {
//		self.id = id
//		self.id_zone = id_zone
//		self.id_currency = id_currency
//		self.call_prefix = call_prefix
//		self.iso_code = iso_code
//		self.active = active
//		self.contains_states = contains_states
//		self.need_identification_number = need_identification_number
//		self.need_zip_code = need_zip_code
//		self.zip_code_format = zip_code_format
//		self.display_tax_label = display_tax_label
//		self.name = name
//	}
}

//extension Countries {
//	init?(jsonDictionary: [String : AnyObject]) {
//		guard let parseName = jsonDictionary["iso_code"] as? String else {
//			return nil
//		}
//		iso_code = parseName
//	}
//}

