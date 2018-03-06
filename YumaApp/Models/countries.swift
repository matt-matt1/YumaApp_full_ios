//
//  countries.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

struct Country: Decodable
{
	public var id: 							Int?//!
	public var idZone: 						String?
	public var idCurrency: 					String?
	public var callPrefix: 					String?
	public var isoCode: 					String?//!..3
	public var active: 						String?//Bool
	public var containsStates: 				String?//!Bool
	public var needIdentificationNumber: 	String?//!Bool
	public var needZipCode: 				String?//Bool
	public var zipCodeFormat: 				String?
	public var displayTaxLabel: 			String?//!Bool
	public var name: 						[IdValue]?//!..64

	enum MemberKeys: String, CodingKey
	{
		case id
		case idZone = 						"id_zone"
		case idCurrency = 					"id_currency"
		case callPrefix = 					"call_prefix"
		case isoCode = 						"iso_code"
		case active
		case containsStates = 				"contains_states"
		case needIdentificationNumber = 	"need_identification_number"
		case needZipCode = 					"need_zip_code"
		case zipCodeFormat = 				"zip_code_format"
		case displayTaxLabel = 				"display_tax_label"
		case name
	}
}
struct Countries: Decodable
{
	let countries: [Country]
}
