//
//  ProductOptionalues.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-20.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductOptionValues: Codable
{
	let product_option_values: [ProductOptionValue]
}
struct ProductOptionValue: Codable
{
	let id: 				Int?
	let idAttributeGroup: 	String?
	let color: 				String?
	let position:			String?
	let name:				[IdValue]?
	
	enum MemberKeys: String, CodingKey
	{
		case id
		case idAttributeGroup = "id_attribute_group"
		case color
		case position
		case name
	}
}
