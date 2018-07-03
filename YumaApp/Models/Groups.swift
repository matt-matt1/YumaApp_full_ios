//
//  Groups.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Groups: Codable//The customer's groups
{
	let groups: [Group]?
}
struct Group: Codable
{
	var id: 					Int?
	var reduction: 				Double?
	var priceDisplayMethod: 	String?
	var showPrices: 			Bool?
	var dateAdd: 				String?
	var dateUpd: 				String?
	let name: 					[IdValue]?
	
	enum CodingKeys: String, CodingKey
	{
		case id
		case reduction
		case priceDisplayMethod = 	"price_display_method"
		case showPrices = 			"show_prices"
		case dateAdd = 				"date_add"
		case dateUpd = 				"date_upd"
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
		reduction = 0
		if let myDbl = try? parent.decode(Double.self, forKey: .reduction)
		{
			reduction = myDbl
		}
		else if let myFlt = try? parent.decode(Float.self, forKey: .reduction)
		{
			reduction = Double(myFlt)
		}
		else if let myInt = try? parent.decode(Int.self, forKey: .reduction)
		{
			reduction = Double(myInt)
		}
		priceDisplayMethod = ""
		if let myInt = try? parent.decode(String.self, forKey: .priceDisplayMethod)
		{
			priceDisplayMethod = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .priceDisplayMethod)
		{
			priceDisplayMethod = ""
		}
		showPrices = false
		if let myInt = try? parent.decode(Bool.self, forKey: .showPrices)
		{
			showPrices = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .showPrices)
		{
			showPrices = str != "0"
		}
		dateAdd = ""
		if let myInt = try? parent.decode(String.self, forKey: .dateAdd)
		{
			dateAdd = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .dateAdd)
		{
			dateAdd = ""
		}
		dateUpd = ""
		if let myInt = try? parent.decode(String.self, forKey: .dateUpd)
		{
			dateUpd = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .dateUpd)
		{
			dateUpd = ""
		}
		name = try parent.decode([IdValue].self, forKey: .name)
	}
}
