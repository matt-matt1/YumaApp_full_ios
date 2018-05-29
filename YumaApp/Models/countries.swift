//
//  countries.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

struct Country: Codable
{
	public var id: 							Int?//!
	public var idZone: 						Int?//String?
	public var idCurrency: 					Int?//String?
	public var callPrefix: 					String?
	public var isoCode: 					String?//!..3
	public var active: 						Bool?//String?//Bool
	public var containsStates: 				Bool?//String?//!Bool
	public var needIdentificationNumber: 	Bool?//String?//!Bool
	public var needZipCode: 				Bool?//String?//Bool
	public var zipCodeFormat: 				String?
	public var displayTaxLabel: 			Bool?//String?//!Bool
	public var name: 						[IdValue]?//!..64

	enum CodingKeys: String, CodingKey
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
	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myNull = try? parent.decodeNil(forKey: .id)
		{
			if !myNull
			{
				if let myInt = try? parent.decode(UInt.self, forKey: .id)
				{
					id = Int(myInt)
				}
				else if let myInt = try? parent.decode(Int.self, forKey: .id)
				{
					id = myInt
				}
				else if let str = try? parent.decode(String.self, forKey: .id)
				{
					id = Int(str)!
				}
			}
		}
		idZone = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idZone)
		{
			idZone = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idZone)
		{
			idZone = Int(str)
		}
		idCurrency = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCurrency)
		{
			idCurrency = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCurrency)
		{
			idCurrency = Int(str)
		}
		callPrefix = ""
		if let myInt = try? parent.decode(String.self, forKey: .callPrefix)
		{
			callPrefix = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .callPrefix)
		{
			callPrefix = ""
		}
		isoCode = ""
		if let myInt = try? parent.decode(String.self, forKey: .isoCode)
		{
			isoCode = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .isoCode)
		{
			isoCode = ""
		}
		active = false
		if let myInt = try? parent.decode(Bool.self, forKey: .active)
		{
			active = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .active)
		{
			active = str != "0"
		}
		containsStates = false
		if let myInt = try? parent.decode(Bool.self, forKey: .containsStates)
		{
			containsStates = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .containsStates)
		{
			containsStates = str != "0"
		}
		needIdentificationNumber = false
		if let myInt = try? parent.decode(Bool.self, forKey: .needIdentificationNumber)
		{
			needIdentificationNumber = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .needIdentificationNumber)
		{
			needIdentificationNumber = str != "0"
		}
		needZipCode = false
		if let myInt = try? parent.decode(Bool.self, forKey: .needZipCode)
		{
			needZipCode = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .needZipCode)
		{
			needZipCode = str != "0"
		}
		zipCodeFormat = ""
		if let myInt = try? parent.decode(String.self, forKey: .zipCodeFormat)
		{
			zipCodeFormat = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .zipCodeFormat)
		{
			zipCodeFormat = ""
		}
		displayTaxLabel = false
		if let myInt = try? parent.decode(Bool.self, forKey: .displayTaxLabel)
		{
			displayTaxLabel = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .displayTaxLabel)
		{
			displayTaxLabel = str != "0"
		}
		name = try parent.decode([IdValue].self, forKey: .name)
	}
}
struct Countries: Codable
{
	let countries: [Country]
}
