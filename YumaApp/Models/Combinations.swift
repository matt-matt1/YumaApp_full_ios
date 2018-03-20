//
//  Combinations.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Combination: Codable
{
	let id: 				Int?//!
	let idProduct: 			String? //!format="isUnsignedId"/><
	let location: 			String? //..64 format="isGenericName"/>
	let ean13: 				String? //..13 format="isEan13"/><
	let isbn: 				String? //..32 format="isIsbn"/><
	let upc: 				String? //..12 format="isUpc"/><
	let quantity: 			String? //..10 format="isInt"/><
	let reference: 			String? //..32
	let supplierReference: 	String? //..32
	let wholesalePrice: 	String? //..27" format="isPrice"/><
	let price: 				String? //..20" format="isNegativePrice"/><
	let ecotax: 			String? //..20" format="isPrice"/><
	let weight: 			String? //format="isFloat"/><
	let unitPriceImpact: 	String? //..20" format="isNegativePrice"/><
	let minimalQuantity: 	String? //required="true" format="isUnsignedId"/><
	let defaultOn: 			String? //format="isBool"/><
	let availableDate: 		String? //format="isDateFormat"/><
	let associations: 		Associations_Combinations?//><product_option_values nodeType="product_option_value"
	
	enum MemberKeys: String, CodingKey
	{
		case idProduct = "id_product" //required="true" format="isUnsignedId"/><
		case location //maxSize="64" format="isGenericName"/>
		case ean13 //maxSize="13" format="isEan13"/><
		case isbn //maxSize="32" format="isIsbn"/><
		case upc //maxSize="12" format="isUpc"/><
		case quantity //maxSize="10" format="isInt"/><
		case reference //maxSize="32"/><
		case supplierReference = "supplier_reference" //maxSize="32"/><
		case wholesalePrice = "wholesale_price" //maxSize="27" format="isPrice"/><
		case price //maxSize="20" format="isNegativePrice"/><
		case ecotax //maxSize="20" format="isPrice"/><
		case weight //format="isFloat"/><
		case unitPriceImpact = "unit_price_impact" //maxSize="20" format="isNegativePrice"/><
		case minimalQuantity = "minimal_quantity" //required="true" format="isUnsignedId"/><
		case defaultOn = "default_on" //format="isBool"/><
		case availableDate = "available_date" //format="isDateFormat"/><
		case associations
	}
}

struct Associations_Combinations: Codable
{
	let productOptionValues: [IdAsString]?
	let images: [IdAsString]?

	enum MemberKeys: String, CodingKey
	{
		case productOptionValues = "product_option_values" //nodeType="product_option_value" api="product_option_values">
		case images //nodeType="image" api="images/products">
	}
}

struct Combinations: Decodable
{
	let combinations: [Combination]?
}
