//
//  Carriers.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct Carrier: Decodable//, Comparable
{
//	public static func <(lhs: Carrier, rhs: Carrier) -> Bool
//	{
//		<#code#>
//	}
//	
//	public static func ==(lhs: Carrier, rhs: Carrier) -> Bool
//	{
//		<#code#>
//	}
	
	var id: 					Int?//!
	var deleted: 				Bool?//Bool
	var isModule: 				Bool?//Bool
	var idTaxRulesGroup: 		Int?
	var idReference: 			Int?
	var name: 					String?//!..64
	var active: 				Bool?//!Bool
	var isFree: 				Bool?//Bool
	var url: 					String?
	var shippingHandling: 		Bool?//Bool
	var shippingExternal: 		Bool?
	var rangeBehavior: 			Bool?//Bool
	var shippingMethod: 		Int?//Int
	var maxWidth: 				Int?//Int
	var maxHeight: 				Int?//Int
	var maxDepth: 				Int?//Int
	var maxWeight: 				Float?//Float
	var grade: 					Int?//..1
	var externalModuleName: 	String?//..64
	var needRange: 				Bool?
	var position: 				Int?
	let delay: 					[IdValue]?//..512
	
	private enum CodingKeys: String, CodingKey
	{
		case id
		case deleted
		case isModule = 			"is_module"
		case idTaxRulesGroup = 		"id_tax_rules_group"
		case idReference = 			"id_reference"
		case name
		case active
		case isFree = 				"is_free"
		case url
		case shippingHandling = 	"shipping_handling"
		case shippingExternal = 	"shipping_external"
		case rangeBehavior = 		"range_behavior"
		case shippingMethod = 		"shipping_method"
		case maxWidth = 			"max_width"
		case maxHeight = 			"max_height"
		case maxDepth = 			"max_depth"
		case maxWeight = 			"max_weight"
		case grade
		case externalModuleName = 	"external_module_name"
		case needRange = 			"need_range"
		case position
		case delay
	}

	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myInt = try? parent.decode(Int.self, forKey: .id)
		{
			id = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .id)
		{
			id = Int(str)
		}
		deleted = false
		if let myInt = try? parent.decode(Bool.self, forKey: .deleted)
		{
			deleted = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .deleted)
		{
			deleted = str != "0"
		}
		isModule = false
		if let myInt = try? parent.decode(Bool.self, forKey: .isModule)
		{
			isModule = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .isModule)
		{
			isModule = str != "0"
		}
		idTaxRulesGroup = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idTaxRulesGroup)
		{
			idTaxRulesGroup = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idTaxRulesGroup)
		{
			idTaxRulesGroup = Int(str)
		}
		idReference = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idReference)
		{
			idReference = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idReference)
		{
			idReference = Int(str)
		}
		name = ""
		if (try? parent.decodeNil(forKey: .name)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .name)
			{
				name = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .name)
			{
				name = String(str)
			}
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
		isFree = false
		if let myInt = try? parent.decode(Bool.self, forKey: .isFree)
		{
			isFree = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .isFree)
		{
			isFree = str != "0"
		}
		url = ""
		if (try? parent.decodeNil(forKey: .url)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .url)
			{
				url = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .url)
			{
				url = String(str)
			}
		}
		shippingHandling = false
		if let myInt = try? parent.decode(Bool.self, forKey: .shippingHandling)
		{
			shippingHandling = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .shippingHandling)
		{
			shippingHandling = str != "0"
		}
		shippingExternal = false
		if let myInt = try? parent.decode(Bool.self, forKey: .shippingExternal)
		{
			shippingExternal = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .shippingExternal)
		{
			shippingExternal = str != "0"
		}
		rangeBehavior = false
		if let myInt = try? parent.decode(Bool.self, forKey: .rangeBehavior)
		{
			rangeBehavior = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .rangeBehavior)
		{
			rangeBehavior = str != "0"
		}
		shippingMethod = 0
		if let myInt = try? parent.decode(Int.self, forKey: .shippingMethod)
		{
			shippingMethod = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .shippingMethod)
		{
			shippingMethod = Int(str)
		}
		maxWidth = 0
		if let myInt = try? parent.decode(Int.self, forKey: .maxWidth)
		{
			maxWidth = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .maxWidth)
		{
			maxWidth = Int(str)
		}
		maxHeight = 0
		if let myInt = try? parent.decode(Int.self, forKey: .maxHeight)
		{
			maxHeight = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .maxHeight)
		{
			maxHeight = Int(str)
		}
		maxDepth = 0
		if let myInt = try? parent.decode(Int.self, forKey: .maxDepth)
		{
			maxDepth = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .maxDepth)
		{
			maxDepth = Int(str)
		}
		maxWeight = 0
		if let myInt = try? parent.decode(Float.self, forKey: .maxWeight)
		{
			maxWeight = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .maxWeight)
		{
			maxWeight = Float(str)!
		}
		grade = 0
		if let myInt = try? parent.decode(Int.self, forKey: .grade)
		{
			grade = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .grade)
		{
			grade = Int(str)
		}
		externalModuleName = ""
		if (try? parent.decodeNil(forKey: .externalModuleName)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .externalModuleName)
			{
				externalModuleName = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .externalModuleName)
			{
				externalModuleName = String(str)
			}
		}
		needRange = false
		if let myInt = try? parent.decode(Bool.self, forKey: .needRange)
		{
			needRange = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .needRange)
		{
			needRange = str != "0"
		}
		position = 0
		if let myInt = try? parent.decode(Int.self, forKey: .position)
		{
			position = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .position)
		{
			position = Int(str)
		}
		delay = try parent.decode([IdValue].self, forKey: .delay)
	}
}
struct CarrierList: Decodable
{
	let carriers: [Carrier]?
}
