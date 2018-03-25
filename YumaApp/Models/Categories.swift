//
//  Categories.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


//private struct DummyCodable: Codable {}

struct aCategory: Codable//, Comparable
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
	
	var id: 					Int?
	var id_parent/*idParent*/: 				String?
	var level_depth/*levelDepth*/: 			String?//read_only
	var /*nb_products_recursive*/nbProductsRecursive: 	String?//read_only//sometimes -1(Int)
	var active: 				String?//!Bool
	var id_shop_default/*idShopDefault*/: 			String?
	var is_root_category/*isRootCategory*/: 		String?//Bool
	var position: 				String?
	var date_add/*dateAdd*/: 				String?//date
	var date_upd/*dateUpd*/: 				String?//date
	var name: 					[IdValue]?//!..128
	var link_rewrite/*linkRewrite*/: 			[IdValue]?//!..128
	var description: 			[IdValue]?//html
	var meta_title/*metaTitle*/: 				[IdValue]?//..128
	var meta_description/*metaDescription*/: 		[IdValue]?//..255
	var meta_keywords/*metaKeywords*/: 			[IdValue]?//..255
	var associations: 			Associations_Categories?
	/*
	init(from decoder: Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
//		if let int = try? values.decode(Int.self, forKey: .id)
//		{
//			id = int
//		}
//		else if let str = try? values.decode(String.self, forKey: .id)
//		{
//			id = Int(str)!
//		}
		id = try! values.decode(Int.self, forKey: .id)
		idParent = try values.decodeIfPresent(String.self, forKey: .idParent) ?? ""
		levelDepth = try? values.decodeIfPresent(String.self, forKey: .levelDepth) ?? ""
		if let str = try? values.decodeIfPresent(String.self, forKey: .nbProductsRecursive)
		{
			nbProductsRecursive = str
		}
		else if let int = try values.decodeIfPresent(Int.self, forKey: .nbProductsRecursive)
		{
			nbProductsRecursive = "\(int)"
		}
		active = try values.decode(String.self, forKey: .active)
		idShopDefault = try values.decodeIfPresent(String.self, forKey: .idShopDefault) ?? ""
		isRootCategory = try values.decodeIfPresent(String.self, forKey: .isRootCategory) ?? ""
		position = try values.decodeIfPresent(String.self, forKey: .position) ?? ""
		dateAdd = try values.decodeIfPresent(String.self, forKey: .dateAdd) ?? ""
		dateUpd = try values.decodeIfPresent(String.self, forKey: .dateUpd) ?? ""
		name = try values.decodeIfPresent([IdValue].self, forKey: .name) ?? nil
		linkRewrite = try values.decodeIfPresent([IdValue].self, forKey: .linkRewrite) ?? nil
		description = try values.decodeIfPresent([IdValue].self, forKey: .description) ?? nil
		metaTitle = try values.decodeIfPresent([IdValue].self, forKey: .metaTitle) ?? nil
		metaDescription = try values.decodeIfPresent([IdValue].self, forKey: .metaDescription) ?? nil
		metaKeywords = try values.decodeIfPresent([IdValue].self, forKey: .metaKeywords) ?? nil
		associations = try values.decodeIfPresent(Associations_Categories.self, forKey: .associations) ?? nil
	}
*/
	/*
	private enum CodingKeys: String, CodingKey
	{
		case id = 					"categoryId"
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
	}*/
}
struct Associations_Categories: Codable
{
	let categories: [IdValue]?
}
struct Categories: Codable
{
	let categories: [aCategory]?
}

