//
//  ProductsJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


//struct IdAsString: Codable
//{
//	let id: String
//}
struct CategoryID: Codable
{
	let id: String
}
struct ImageID: Codable
{
	let id: String
}
struct CombinationID: Codable
{
	let id: String
}
struct ProductOptionValueID: Codable
{
	let id: String
}
struct ProductFeatureID: Codable
{
	let id: String
	let id_feature_value: String?
}
struct TagID: Codable
{
	let id: String
}
struct StockAvailable: Codable
{
	let id: String
	let id_product_attribute: String?
}
struct Accessories: Codable
{
	let id: String
}
struct ProductBundle: Codable
{
	let id: String
	let quantity: String?
}
struct ProductsAssociations: Codable
{
	let categories: 			[IdAsString]?//[CategoryID]?
	let images: 				[IdAsString]?//[ImageID]?
	let combinations: 			[IdAsString]?//[CombinationID]?
	let product_option_values: 	[IdAsString]?//[ProductOptionValueID]?
	let product_features: 		[IdAsString]?//[ProductFeatureID]?
	let tags: 					[IdAsString]?//[TagID]?
	let stock_availables: 		[StockAvailable]?
	let accessories:			[Accessories]?
	let product_bundle:			[ProductBundle]?
	var imageData:				Data?//ADDED - NOT IN API
}
//struct Product_Tax
//{
//	let id: Int
//	let rate: String
//	let active: String
//	let deleted: String
//	let name: String
//}
/*
struct aProduct: Codable
{
	let id: 						Int?//!
	let id_manufacturer: 			String?
	let id_supplier: 				String?
	let id_category_default: 			String?
	let new: 						String?
	let cache_default_attribute: 		String?
	let id_default_image: 			String?
	let id_default_combination/*idDefaultCombination*/: 		Int?
	let id_tax_rules_group: 			String?
	let position_in_category/*positionInCategory*/: 		String?
	let /*manufacturer_name*/manufacturerName: 			String?//read_only
	let quantity: 					String?//read_only
	let type: 						String?
	let id_shop_default/*idShopDefault*/: 				String?
	let reference: 					String?//..32
	let supplier_reference/*supplierReference*/: 			String?//..32
	let location: 					String?//..64
	let width: 						String?//Float
	let height: 					String?//Float
	let depth: 						String?//Float
	let weight: 					String?//Float
	let quantity_discount/*quantityDiscount*/: 			String?//Bool
	let ean13: 						String?//..13
	let isbn: 						String?//..32
	let upc: 						String?//..12
	let cache_is_pack/*cacheIsPack*/: 				String?//Bool
	let cache_has_attachments/*cacheHasAttachments*/: 		String?//Bool
	let is_virtual/*isVirtual*/: 					String?//Bool
	let state: 						String?
	let onSale: 					String?//Bool
	let onlineOnly: 				String?//Bool
	let ecotax: 					String?
	let minimalQuantity: 			String?
	let price: 						String?
	let wholesalePrice: 			String?
	let unity: 						String?
	let unitPriceRatio: 			String?
	let additionalShippingCost: 	String?
	let customizable: 				String?//Int
	let textFields: 				String?//Int
	let uploadableFiles: 			String?//Int
	let active: 					String?//Bool
	let redirectType: 				String?
	let idTypeRedirected: 			String?
	let availableForOrder: 			String?//Bool
	let availableDate: 				String?//date
	let showCondition: 				String?//Bool
	let condition: 					String?
	let showPrice: 					String?//Bool
	let indexed: 					String?//Bool
	let visibility: 				String?
	let advancedStockManagement: 	String?//Bool
	let dateAdd: 					String?//date
	let dateUpd: 					String?//date
	let packStockType: 				String?//Int
	let metaDescription: 			[IdValue]?//..255
	let metaKeywords: 				[IdValue]?//..255
	let metaTitle: 					[IdValue]?//..128
	let link_rewrite: 				[IdValue]?//..128
	let name: 						[IdValue]?//..128
	let description: 				[IdValue]?//html
	let description_short: 			[IdValue]?//html
	let availableNow: 				[IdValue]?//..255
	let availableLater: 			[IdValue]?//..255
	var associations: 				ProductsAssociations?
}
*/
struct aProduct: Codable
{
	var id: 						Int
	var idManufacturer: 			Int?/*String?*/
	var idSupplier: 				Int?/*String?*/
	var idCategoryDefault: 			Int?/*String?*/
	var new: 						Bool?/*String?*/
	var cacheDefaultAttribute: 		Int?/*String?*/
	var idDefaultImage: 			Int?/*String?*/
	var idDefaultCombination: 		/*String?*/Int?
	var idTaxRulesGroup: 			Int?/*String?*/
	var positionInCategory: 		Int?/*String?*/
	var manufacturerName: 			String?//read_only
	var quantity: 					Int?/*String?*///read_only
	let type: 						String?
	var idShopDefault: 				Int?/*String?*/
	var reference: 					String?//..32
	var supplierReference: 			String?//..32
	var location: 					String?//..64
	var width: 						Float?/*String?*///Float
	var height: 					Float?/*String?*///Float
	var depth: 						Float?/*String?*///Float
	var weight: 					Float?/*String?*///Float
	var quantityDiscount: 			Bool?/*String?*///Bool
	var ean13: 						String?//..13
	var isbn: 						String?//..32
	var upc: 						String?//..12
	var cacheIsPack: 				Bool?/*String?*///Bool
	var cacheHasAttachments: 		Bool?/*String?*///Bool
	var isVirtual: 					Bool?/*String?*///Bool
	let state: 						String?
	var onSale: 					Bool?/*String?*///Bool
	var onlineOnly: 				Bool?/*String?*///Bool
	var ecotax: 					Float?/*String?*/
	let minimalQuantity: 			String?
	var price: 						Float?/*String?*/
	var wholesalePrice: 			Float?/*String?*/
	let unity: 						String?
	var unitPriceRatio: 			Float?/*String?*/
	var additionalShippingCost: 	Float?/*String?*/
	var customizable: 				Int?/*String?*///Int
	var textFields: 				Int?/*String?*///Int
	var uploadableFiles: 			Int?/*String?*///Int
	var active: 					Bool?/*String?*///Bool
	let redirectType: 				String?
	var idTypeRedirected: 			Int?/*String?*/
	var availableForOrder: 			Bool?/*String?*///Bool
	var availableDate: 				Date?/*String?*///date
	var showCondition: 				Bool?/*String?*///Bool
	let condition: 					String?
	var showPrice: 					Bool?/*String?*///Bool
	var indexed: 					Bool?/*String?*///Bool
	let visibility: 				String?
	var advancedStockManagement: 	Bool?/*String?*///Bool
	var dateAdd: 					Date?/*String?*///date
	var dateUpd: 					Date?/*String?*///date
	var packStockType: 				Int?/*String?*///Int
	let metaDescription: 			[IdValue]?//..255
	let metaKeywords: 				[IdValue]?//..255
	let metaTitle: 					[IdValue]?//..128
	let linkRewrite: 				[IdValue]?//..128
	let name: 						[IdValue]?//..128
	let description: 				[IdValue]?//html
	let descriptionShort: 			[IdValue]?//html
	let availableNow: 				[IdValue]?//..255
	let availableLater: 			[IdValue]?//..255
	var associations: 				ProductsAssociations?

	enum CodingKeys: String, CodingKey
	{
		case id
		case idManufacturer = 			"id_manufacturer"
		case idSupplier = 				"id_supplier"
		case idCategoryDefault = 		"id_category_default"
		case new
		case cacheDefaultAttribute = 	"cache_default_attribute"
		case idDefaultImage = 			"id_default_image"
		case idDefaultCombination = 	"id_default_combination"
		case idTaxRulesGroup = 			"id_tax_rules_group"
		case positionInCategory = 		"position_in_category"
		case manufacturerName = 		"manufacturer_name"
		case quantity
		case type
		case idShopDefault = 			"id_shop_default"
		case reference
		case supplierReference = 		"supplier_reference"
		case location
		case width
		case height
		case depth
		case weight
		case quantityDiscount = 		"quantity_discount"
		case ean13
		case isbn
		case upc
		case cacheIsPack = 				"cache_is_pack"
		case cacheHasAttachments = 		"cache_has_attachments"
		case isVirtual = 				"is_virtual"
		case state
		case onSale = 					"on_sale"
		case onlineOnly = 				"online_only"
		case ecotax
		case minimalQuantity = 			"minimal_quantity"
		case price
		case wholesalePrice = 			"wholesale_price"
		case unity
		case unitPriceRatio = 			"unit_price_ratio"
		case additionalShippingCost = 	"additional_shipping_cost"
		case customizable
		case textFields = 				"text_fields"
		case uploadableFiles = 			"uploadable_files"
		case active
		case redirectType = 			"redirect_type"
		case idTypeRedirected = 		"id_type_redirected"
		case availableForOrder = 		"available_for_order"
		case availableDate = 			"available_date"
		case showCondition = 			"show_condition"
		case condition
		case showPrice = 				"show_price"
		case indexed
		case visibility
		case advancedStockManagement = 	"advanced_stock_management"
		case dateAdd = 					"date_add"
		case dateUpd = 					"date_upd"
		case packStockType = 			"pack_stock_type"
		case metaDescription = 			"meta_description"
		case metaKeywords = 			"meta_keywords"
		case metaTitle = 				"meta_title"
		case linkRewrite = 				"link_rewrite"
		case name
		case description
		case descriptionShort = 		"description_short"
		case availableNow = 			"available_now"
		case availableLater = 			"available_later"
		case associations
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
//				else if (try? parent.decodeNil(forKey: .id)) != nil
//				{
//					id = myNull ? 5 : 4
//				}
				else if let str = try? parent.decode(String.self, forKey: .id)
				{
					id = Int(str)!
				}
			}
		}
		idManufacturer = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idManufacturer)
		{
			idManufacturer = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idManufacturer)
		{
			idManufacturer = Int(str)
		}
		idSupplier = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idSupplier)
		{
			idSupplier = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idSupplier)
		{
			idSupplier = Int(str)
		}
		idCategoryDefault = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCategoryDefault)
		{
			idCategoryDefault = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCategoryDefault)
		{
			idCategoryDefault = Int(str)
		}
		new = false
		if let myInt = try? parent.decode(Bool.self, forKey: .new)
		{
			new = myInt
		}
//		else if (try? parent.decodeNil(forKey: .new)) != nil
//		{
//			new = false
//		}
		else if let str = try? parent.decode(String.self, forKey: .new)
		{
			new = str != "0"
		}
		cacheDefaultAttribute = 0
		if let myInt = try? parent.decode(Int.self, forKey: .cacheDefaultAttribute)
		{
			cacheDefaultAttribute = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .cacheDefaultAttribute)
		{
			cacheDefaultAttribute = Int(str)
		}
		idDefaultImage = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idDefaultImage)
		{
			idDefaultImage = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idDefaultImage)
		{
			idDefaultImage = Int(str)
		}
		idDefaultCombination = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idDefaultCombination)
		{
			idDefaultCombination = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idDefaultCombination)
		{
			idDefaultCombination = Int(str)
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
		positionInCategory = 0
		if let myInt = try? parent.decode(Int.self, forKey: .positionInCategory)
		{
			positionInCategory = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .positionInCategory)
		{
			positionInCategory = Int(str)!
		}
		manufacturerName = ""
		if let myInt = try? parent.decode(String.self, forKey: .manufacturerName)
		{
			manufacturerName = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .manufacturerName)
		{
			manufacturerName = ""
		}
//		quantity = parent.quantity
		quantity = 0
		if let myInt = try? parent.decode(Int.self, forKey: .quantity)
		{
			quantity = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .quantity)
		{
			quantity = Int(str)
		}
		//type = parent.type
		type = try? parent.decode(String.self, forKey: .type)
		//id_shop_default/*idShopDefault*/ = parent.id_shop_default/*idShopDefault*/
		idShopDefault = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShopDefault)
		{
			idShopDefault = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idShopDefault)
		{
			idShopDefault = Int(str)
		}
		//reference = parent.reference
		reference = ""
		if let myInt = try? parent.decode(Int.self, forKey: .reference)
		{
			reference = String(myInt)
		}
//		else if let myInt = try? parent.decode(Bool.self, forKey: .reference)
//		{
//			reference = myInt ? 2 : 5
//		}
//		else if let myInt = try? parent.decode(Int8.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(Int16.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(Int32.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(Int64.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(UInt8.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(UInt16.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(UInt32.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(UInt64.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(UInt.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(Float.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if let myInt = try? parent.decode(Double.self, forKey: .reference)
//		{
//			reference = Int(myInt)
//		}
//		else if (try? parent.decodeNil(forKey: .reference)) != nil
//		{
//			reference = 0
//			reference = myInt ? 2 : 5
//		}
		else if let str = try? parent.decode(String.self, forKey: .reference)
		{
			reference = str
		}
		//supplier_reference/*supplierReference*/ = parent.supplier_reference/*supplierReference*/
		supplierReference = ""
		if let myInt = try? parent.decode(Int.self, forKey: .supplierReference)
		{
			supplierReference = String(myInt)
		}
//		else if (try? parent.decodeNil(forKey: .supplierReference)) != nil
//		{
//			supplierReference = 0
//		}
		else if let str = try? parent.decode(String.self, forKey: .supplierReference)
		{
			supplierReference = str
		}
		//location = parent.location
		location = ""
		if let myInt = try? parent.decode(Int.self, forKey: .location)
		{
			location = String(myInt)
		}
//		else if (try? parent.decodeNil(forKey: .location)) != nil
//		{
//			location = 0
//		}
		else if let str = try? parent.decode(String.self, forKey: .location)
		{
			location = str
		}
		//width = parent.width
		width = 0
		if let myInt = try? parent.decode(Float.self, forKey: .width)
		{
			width = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .width)
		{
			width = Float(str)
		}
		//height = parent.height
		height = 0
		if let myInt = try? parent.decode(Float.self, forKey: .height)
		{
			height = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .height)
		{
			height = Float(str)!
		}
		//depth = parent.depth
		depth = 0
		if let myInt = try? parent.decode(Float.self, forKey: .depth)
		{
			depth = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .depth)
		{
			depth = Float(str)!
		}
		//weight = parent.weight
		weight = 0
		if let myInt = try? parent.decode(Float.self, forKey: .weight)
		{
			weight = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .weight)
		{
			weight = Float(str)!
		}
		//quantity_discount/*quantityDiscount*/ = parent.quantity_discount/*quantityDiscount*/
		quantityDiscount = false
		if let myInt = try? parent.decode(Bool.self, forKey: .quantityDiscount)
		{
			quantityDiscount = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .quantityDiscount)
		{
			quantityDiscount = str != "0"
		}
		//ean13 = parent.ean13
		ean13 = ""
		if (try? parent.decodeNil(forKey: .ean13)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .ean13)
			{
				ean13 = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .ean13)
			{
				ean13 = String(str)
			}
		}
//		else
//		{
//			ean13 = ""
//		}
		//isbn = parent.isbn
		//isbn = ""
		if let nullVal = try? parent.decodeNil(forKey: .isbn)
		{
			if !nullVal//compare other types if not null
			{
				if let myInt = try? parent.decode(Int.self, forKey: .isbn)
				{
					isbn = String(myInt)
				}
				else if let str = try? parent.decode(String.self, forKey: .isbn)
				{
					isbn = String(str)
				}
			}
			else
			{
				isbn = ""
			}
		}
//		else
//		{
//			isbn = ""
//		}
		//upc = parent.upc
		upc = ""
		if let myInt = try? parent.decode(Int.self, forKey: .upc)
		{
			upc = String(myInt)
		}
//		else if (try? parent.decodeNil(forKey: .upc)) != nil
//		{
//			upc = ""
//		}
		else if let str = try? parent.decode(String.self, forKey: .upc)
		{
			upc = String(str)
		}
		//cache_is_pack/*cacheIsPack*/ = parent.cache_is_pack/*cacheIsPack*/
		cacheIsPack = false
		if let myInt = try? parent.decode(Bool.self, forKey: .cacheIsPack)
		{
			cacheIsPack = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .cacheIsPack)
		{
			cacheIsPack = str != "0"
		}
		//cache_has_attachments/*cacheHasAttachments*/ = parent.cache_has_attachments/*cacheHasAttachments*/
		cacheHasAttachments = false
		if let myInt = try? parent.decode(Bool.self, forKey: .cacheHasAttachments)
		{
			cacheHasAttachments = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .cacheHasAttachments)
		{
			cacheHasAttachments = str != "0"
		}
		//is_virtual/*isVirtual*/ = parent.is_virtual/*isVirtual*/
		isVirtual = false
		if let myInt = try? parent.decode(Bool.self, forKey: .isVirtual)
		{
			isVirtual = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .isVirtual)
		{
			isVirtual = str != "0"
		}
		//state = parent.state
		state = try? parent.decode(String.self, forKey: .state)
		//onSale = parent.onSale
		onSale = false
		if let myInt = try? parent.decode(Bool.self, forKey: .onSale)
		{
			onSale = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .onSale)
		{
			onSale = str != "0"
		}
		//onlineOnly = parent.onlineOnly
		onlineOnly = false
		if let myInt = try? parent.decode(Bool.self, forKey: .onlineOnly)
		{
			onlineOnly = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .onlineOnly)
		{
			onlineOnly = str != "0"
		}
		//ecotax = parent.ecotax
		ecotax = 0
		if let myInt = try? parent.decode(Float.self, forKey: .ecotax)
		{
			ecotax = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .ecotax)
		{
			ecotax = Float(str)!
		}
		//minimalQuantity = parent.minimalQuantity
		minimalQuantity = try? parent.decode(String.self, forKey: .minimalQuantity)
		//price = parent.price
		price = 0
		if let myInt = try? parent.decode(Float.self, forKey: .price)
		{
			price = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .price)
		{
			price = Float(str)
		}
		//wholesalePrice = parent.wholesalePrice
		wholesalePrice = 0
		if let myInt = try? parent.decode(Float.self, forKey: .wholesalePrice)
		{
			wholesalePrice = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .wholesalePrice)
		{
			wholesalePrice = Float(str)
		}
		//unity = parent.unity
		unity = try? parent.decode(String.self, forKey: .unity)
		//unitPriceRatio = parent.unitPriceRatio
		unitPriceRatio = 0
		if let myInt = try? parent.decode(Float.self, forKey: .unitPriceRatio)
		{
			unitPriceRatio = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .unitPriceRatio)
		{
			unitPriceRatio = Float(str)
		}
		//additionalShippingCost = parent.additionalShippingCost
		additionalShippingCost = 0
		if let myInt = try? parent.decode(Float.self, forKey: .additionalShippingCost)
		{
			additionalShippingCost = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .additionalShippingCost)
		{
			additionalShippingCost = Float(str)!
		}
		//customizable = parent.customizable
		customizable = 0
		if let myInt = try? parent.decode(Int.self, forKey: .customizable)
		{
			customizable = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .customizable)
		{
			customizable = Int(str)
		}
		//textFields = parent.textFields
		textFields = 0
		if let myInt = try? parent.decode(Int.self, forKey: .textFields)
		{
			textFields = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .textFields)
		{
			textFields = Int(str)!
		}
		//uploadableFiles = parent.uploadableFiles
		uploadableFiles = 0
		if let myInt = try? parent.decode(Int.self, forKey: .uploadableFiles)
		{
			uploadableFiles = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .uploadableFiles)
		{
			uploadableFiles = Int(str)
		}
		//active = parent.active
		active = false
		if let myInt = try? parent.decode(Bool.self, forKey: .active)
		{
			active = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .active)
		{
			active = str != "0"
		}
		//redirectType = parent.redirectType
		redirectType = try? parent.decode(String.self, forKey: .redirectType)
		//idTypeRedirected = parent.idTypeRedirected
		idTypeRedirected = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idTypeRedirected)
		{
			idTypeRedirected = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idTypeRedirected)
		{
			idTypeRedirected = Int(str)
		}
		//availableForOrder = parent.availableForOrder
		availableForOrder = false
		if let myInt = try? parent.decode(Bool.self, forKey: .availableForOrder)
		{
			availableForOrder = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .availableForOrder)
		{
			availableForOrder = str != "0"
		}
		//availableDate = parent.availableDate
		availableDate = nil
		if let myInt = try? parent.decode(Date.self, forKey: .availableDate)
		{
			availableDate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .availableDate)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			availableDate = df.date(from: str)
		}
		//showCondition = parent.showCondition
		showCondition = false
		if let myInt = try? parent.decode(Bool.self, forKey: .showCondition)
		{
			showCondition = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .showCondition)
		{
			showCondition = str != "0"
		}
		//condition = parent.condition
		condition = try? parent.decode(String.self, forKey: .condition)
		//showPrice = parent.showPrice
		showPrice = false
		if let myInt = try? parent.decode(Bool.self, forKey: .showPrice)
		{
			showPrice = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .showPrice)
		{
			showPrice = str != "0"
		}
		//indexed = parent.indexed
		indexed = false
		if let myInt = try? parent.decode(Bool.self, forKey: .indexed)
		{
			indexed = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .indexed)
		{
			indexed = str != "0"
		}
		//visibility = parent.visibility
		visibility = try? parent.decode(String.self, forKey: .visibility)
		//advancedStockManagement = parent.advancedStockManagement
		advancedStockManagement = false
		if let myInt = try? parent.decode(Bool.self, forKey: .advancedStockManagement)
		{
			advancedStockManagement = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .advancedStockManagement)
		{
			advancedStockManagement = str != "0"
		}
		//dateAdd = parent.dateAdd
		dateAdd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .dateAdd)
		{
			dateAdd = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .dateAdd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			dateAdd = df.date(from: str)
		}
		//dateUpd = parent.dateUpd
		dateUpd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .dateUpd)
		{
			dateUpd = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .dateUpd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			dateUpd = df.date(from: str)
		}
		//packStockType = parent.packStockType
		packStockType = 0
		if let myInt = try? parent.decode(Int.self, forKey: .packStockType)
		{
			packStockType = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .packStockType)
		{
			packStockType = Int(str)
		}
		//metaDescription = parent.metaDescription
		metaDescription = try parent.decode([IdValue].self, forKey: .metaDescription)
		//metaKeywords = parent.metaKeywords
		metaKeywords = try parent.decode([IdValue].self, forKey: .metaKeywords)
		//metaTitle = parent.metaTitle
		metaTitle = try parent.decode([IdValue].self, forKey: .metaTitle)
		//link_rewrite = parent.link_rewrite
		linkRewrite = try parent.decode([IdValue].self, forKey: .linkRewrite)
		//name = parent.name
		name = try parent.decode([IdValue].self, forKey: .name)
		//description = parent.description
		description = try parent.decode([IdValue].self, forKey: .description)
		//description_short/*descriptionShort*/ = parent.description_short/*descriptionShort*/
		descriptionShort = try parent.decode([IdValue].self, forKey: .descriptionShort)
		//availableNow = parent.availableNow
		availableNow = try parent.decode([IdValue].self, forKey: .availableNow)
		//availableLater = parent.availableLater
		availableLater = try parent.decode([IdValue].self, forKey: .availableLater)
		//associations = parent.associations
		associations = try parent.decode(ProductsAssociations.self, forKey: .associations)
	}
}
struct JSONProducts: Codable
{
	let products: [aProduct]?
}


/*
extension aProduct: Decodable
{
	private struct aProduct2: Decodable
	{
		var id: 						Int?//!
		var id_manufacturer/*idManufacturer*/: 			String?
		var id_supplier/*idSupplier*/: 				String?
		var id_category_default/*idCategoryDefault*/: 			String?
		var new: 						String?
		var cache_default_attribute/*cacheDefaultAttribute*/: 		String?
		var id_default_image/*idDefaultImage*/: 			String?
		var /*id_default_combination*/idDefaultCombination: 		Int?
		var id_tax_rules_group/*idTaxRulesGroup*/: 			String?
		var position_in_category/*positionInCategory*/: 		String?
		var manufacturer_name/*manufacturerName*/: 			String?//read_only
		var quantity: 					String?//read_only
		var type: 						String?
		var id_shop_default/*idShopDefault*/: 				String?
		var reference: 					String?//..32
		var supplier_reference/*supplierReference*/: 			String?//..32
		var location: 					String?//..64
		var width: 						String?//Float
		var height: 					String?//Float
		var depth: 						String?//Float
		var weight: 					String?//Float
		var quantity_discount/*quantityDiscount*/: 			String?//Bool
		var ean13: 						String?//..13
		var isbn: 						String?//..32
		var upc: 						String?//..12
		var cache_is_pack/*cacheIsPack*/: 				String?//Bool
		var cache_has_attachments/*cacheHasAttachments*/: 		String?//Bool
		var is_virtual/*isVirtual*/: 					String?//Bool
		var state: 						String?
		var onSale: 					String?//Bool
		var onlineOnly: 				String?//Bool
		var ecotax: 					String?
		var minimalQuantity: 			String?
		var price: 						String?
		var wholesalePrice: 			String?
		var unity: 						String?
		var unitPriceRatio: 			String?
		var additionalShippingCost: 	String?
		var customizable: 				String?//Int
		var textFields: 				String?//Int
		var uploadableFiles: 			String?//Int
		var active: 					String?//Bool
		var redirectType: 				String?
		var idTypeRedirected: 			String?
		var availableForOrder: 			String?//Bool
		var availableDate: 				String?//date
		var showCondition: 				String?//Bool
		var condition: 					String?
		var showPrice: 					String?//Bool
		var indexed: 					String?//Bool
		var visibility: 				String?
		var advancedStockManagement: 	String?//Bool
		var dateAdd: 					String?//date
		var dateUpd: 					String?//date
		var packStockType: 				String?//Int
		var metaDescription: 			[IdValue]?//..255
		var metaKeywords: 				[IdValue]?//..255
		var metaTitle: 					[IdValue]?//..128
		var link_rewrite: 				[IdValue]?//..128
		var name: 						[IdValue]?//..128
		var description: 				[IdValue]?//html
		var description_short/*descriptionShort*/: 			[IdValue]?//html
		var availableNow: 				[IdValue]?//..255
		var availableLater: 			[IdValue]?//..255
		var associations: 				ProductsAssociations?
	}
	
	private enum CodingKeys: String, CodingKey
	{
		case products
	}
	
	init(from decoder: Decoder) throws
	{
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let parent  = try container.decode(aProduct2.self, forKey: .products)
		id = parent.id
		id_manufacturer/*idManufacturer*/ = parent.id_manufacturer/*idManufacturer*/
		id_supplier/*idSupplier*/ = parent.id_supplier/*idSupplier*/
		id_category_default/*idCategoryDefault*/ = parent.id_category_default/*idCategoryDefault*/
		new = parent.new
		cache_default_attribute/*cacheDefaultAttribute*/ = parent.cache_default_attribute/*cacheDefaultAttribute*/
		id_default_image/*idDefaultImage*/ = parent.id_default_image/*idDefaultImage*/
		idDefaultCombination/*id_default_combination*/ = parent.idDefaultCombination/*id_default_combination*/
		id_tax_rules_group/*idTaxRulesGroup*/ = parent.id_tax_rules_group/*idTaxRulesGroup*/
		position_in_category/*positionInCategory*/ = parent.position_in_category/*positionInCategory*/
		manufacturer_name/*manufacturerName*/ = parent.manufacturer_name/*manufacturerName*/
		quantity = parent.quantity
		type = parent.type
		id_shop_default/*idShopDefault*/ = parent.id_shop_default/*idShopDefault*/
		reference = parent.reference
		supplier_reference/*supplierReference*/ = parent.supplier_reference/*supplierReference*/
		location = parent.location
		width = parent.width
		height = parent.height
		depth = parent.depth
		weight = parent.weight
		quantity_discount/*quantityDiscount*/ = parent.quantity_discount/*quantityDiscount*/
		ean13 = parent.ean13
		isbn = parent.isbn
		upc = parent.upc
		cache_is_pack/*cacheIsPack*/ = parent.cache_is_pack/*cacheIsPack*/
		cache_has_attachments/*cacheHasAttachments*/ = parent.cache_has_attachments/*cacheHasAttachments*/
		is_virtual/*isVirtual*/ = parent.is_virtual/*isVirtual*/
		state = parent.state
		onSale = parent.onSale
		onlineOnly = parent.onlineOnly
		ecotax = parent.ecotax
		minimalQuantity = parent.minimalQuantity
		price = parent.price
		wholesalePrice = parent.wholesalePrice
		unity = parent.unity
		unitPriceRatio = parent.unitPriceRatio
		additionalShippingCost = parent.additionalShippingCost
		customizable = parent.customizable
		textFields = parent.textFields
		uploadableFiles = parent.uploadableFiles
		active = parent.active
		redirectType = parent.redirectType
		idTypeRedirected = parent.idTypeRedirected
		availableForOrder = parent.availableForOrder
		availableDate = parent.availableDate
		showCondition = parent.showCondition
		condition = parent.condition
		showPrice = parent.showPrice
		indexed = parent.indexed
		visibility = parent.visibility
		advancedStockManagement = parent.advancedStockManagement
		dateAdd = parent.dateAdd
		dateUpd = parent.dateUpd
		packStockType = parent.packStockType
		metaDescription = parent.metaDescription
		metaKeywords = parent.metaKeywords
		metaTitle = parent.metaTitle
		link_rewrite = parent.link_rewrite
		name = parent.name
		description = parent.description
		description_short/*descriptionShort*/ = parent.description_short/*descriptionShort*/
		availableNow = parent.availableNow
		availableLater = parent.availableLater
		associations = parent.associations
	}
}
*/
