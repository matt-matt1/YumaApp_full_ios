//
//  Manufacturers.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Manufacturers: Decodable
{
	let manufacturers: [Manufacturer]?
}
struct Manufacturer: Decodable
{
	let id:					Int
	let active: 			String?
	let linkRewrite: 		String?//read_only
	let name: 				String//..64
	let dateAdd: 			String?
	let dateUpd: 			String?
	let description: 		[IdValue]?
	let shortDescription: 	[IdValue]?
	let metaTitle: 			[IdValue]?//..128
	let metaDescription: 	[IdValue]?
	let metaKeywords: 		[IdValue]?
	let associations: 		Associations_Manufacturer?

	enum MemberKeys: String, CodingKey
	{
		case active
		case linkRewrite = 			"link_rewrite"
		case name
		case dateAdd = 				"date_add"
		case dateUpd = 				"date_upd"
		case description
		case shortDescription = 	"short_description"
		case metaTitle = 			"meta_title"
		case metaDescription = 		"meta_description"
		case metaKeywords = 		"meta_keywords"
		case associations
	}
}
struct Associations_Manufacturer: Decodable
{
	let addresses: [AddressID]?
}
struct AddressID: Decodable
{
	let id: String?
}
