//
//  ProductOption.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-22.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductOptions: Codable
{
	let product_options: [ProductOption]?
}
struct ProductOption: Codable
{
	let id: 			Int?
	let is_color_group/*isColorGroup*/: 	String?
	let group_type/*groupType*/: 		String?
	let position: 		String?
	let name: 			[IdValue]?
	let public_name/*publicName*/: 	[IdValue]?
	let associations: 	ProductOptionValuesAssociations?
	
//	private enum MemberKeys: String, CodingKey
//	{
//		//case id
//		case isColorGroup = "is_color_group"
//		case groupType = 	"group_type"
//		case position
//		case name
//		case publicName = 	"public_name"
//		case associations
//	}
}
struct ProductOptionValuesAssociations: Codable
{
	let product_option_values: [IdAsString]
}
