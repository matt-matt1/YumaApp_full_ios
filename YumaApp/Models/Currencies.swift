//
//  Currencies.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Currencies: Decodable
{
	let currencies: [Currency]?
}
struct Currency: Decodable
{
	let name: 			String?//!..64
	let isoCode: 		String?//!..3
	let conversionRate: String?//!Float
	let deleted: 		String?//Bool
	let active: 		String?//Bool
	
	enum MemberKeys: String, CodingKey
	{
		case name
		case isoCode = 			"iso_code"
		case conversionRate = 	"conversion_rate"
		case deleted
		case active
	}
}
