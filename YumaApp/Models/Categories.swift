//
//  Categories.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct aCategory: Decodable//, Comparable
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
	
	let id: 					Int
	let idParent: 				String?
	let levelDepth: 			String?//read_only
	let nbProductsRecursive: 	String?//read_only
	let active: 				String//Bool
	let idShopDefault: 			String?
	let isRootCategory: 		String?//Bool
	let position: 				String?
	let dateAdd: 				String?//date
	let dateUpd: 				String?//date
	let name: 					[IdValue]//..128
	let linkRewrite: 			[IdValue]//..128
	let description: 			[IdValue]?//html
	let metaTitle: 				[IdValue]?//..128
	let metaDescription: 		[IdValue]?//..255
	let metaKeywords: 			[IdValue]?//..255
	let associations: 			Associations_Categories?
	
	private enum CodingKeys: String, CodingKey
	{
		case id
		case idParent = 			"id_parent"
		case levelDepth = 			"level_depth"
		case nbProductsRecursive = 	"nb_products_recursive"
		case active
		case idShopDefault = 		"id_shop_default"
		case isRootCategory = 		"is_root_category"
		case position
		case dateAdd = 				"date_add"
		case dateUpd = 				"date_upd"
		case name
		case linkRewrite = 			"link_rewrite"
		case description
		case metaTitle = 			"meta_title"
		case metaDescription = 		"meta_description"
		case metaKeywords = 		"meta_keywords"
		case associations
	}
}
struct Associations_Categories: Decodable
{
	let categories: [IdValue]?
}
struct Categories: Decodable
{
	let categories: [aCategory]?
}

