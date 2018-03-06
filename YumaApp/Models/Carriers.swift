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
	
	let id: 					Int?//!
	let deleted: 				String?//Bool
	let isModule: 				String?//Bool
	let idTaxRulesGroup: 		String?
	let idReference: 			String?
	let name: 					String?//!..64
	let active: 				String?//!Bool
	let isFree: 				String?//Bool
	let url: 					String?
	let shippingHandling: 		String?//Bool
	let shippingExternal: 		String?
	let rangeBehavior: 			String?//Bool
	let shippingMethod: 		String?//Int
	let maxWidth: 				String?//Int
	let maxHeight: 				String?//Int
	let maxDepth: 				String?//Int
	let maxWeight: 				String?//Float
	let grade: 					String?//..1
	let externalModuleName: 	String?//..64
	let needRange: 				String?
	let position: 				String?
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
}
struct CarrierList: Decodable
{
	let carriers: [Carrier]?
}
