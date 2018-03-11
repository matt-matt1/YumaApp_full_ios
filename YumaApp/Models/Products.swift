//
//  ProductsJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


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
	let id_feature_value: String
}
struct TagID: Codable
{
	let id: String
}
struct StockAvailable: Codable
{
	let id: String
	let id_product_attribute: String
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
struct Associations_Products: Codable
{
	let categories: 			[CategoryID]?
	let images: 				[ImageID]?
	let combinations: 			[CombinationID]?
	let product_option_values: 	[ProductOptionValueID]?
	let product_features: 		[ProductFeatureID]?
	let tags: 					[TagID]?
	let stock_availables: 		[StockAvailable]?
	let accessories:			[Accessories]?
	let product_bundle:			[ProductBundle]?
}
//struct Product_Tax
//{
//	let id: Int
//	let rate: String
//	let active: String
//	let deleted: String
//	let name: String
//}
struct aProduct: Codable
{
	let id: 						Int?//!
	let idManufacturer: 			String?
	let idSupplier: 				String?
	let idCategoryDefault: 			String?
	let new: 						String?
	let cacheDefaultAttribute: 		String?
	let idDefaultHmage: 			String?
	let idDefaultCombination: 		Int?
	let idTaxRulesGroup: 			String?
	let positionInCategory: 		String?
	let manufacturerName: 			String?//read_only
	let quantity: 					String?//read_only
	let type: 						String?
	let idShopDefault: 				String?
	let reference: 					String?//..32
	let supplierReference: 			String?//..32
	let location: 					String?//..64
	let width: 						String?//Float
	let height: 					String?//Float
	let depth: 						String?//Float
	let weight: 					String?//Float
	let quantityDiscount: 			String?//Bool
	let ean13: 						String?//..13
	let isbn: 						String?//..32
	let upc: 						String?//..12
	let cacheIsPack: 				String?//Bool
	let cacheHasAttachments: 		String?//Bool
	let isVirtual: 					String?//Bool
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
	let linkRewrite: 				[IdValue]?//..128
	let name: 						[IdValue]?//..128
	let description: 				[IdValue]?//html
	let descriptionShort: 			[IdValue]?//html
	let availableNow: 				[IdValue]?//..255
	let availableLater: 			[IdValue]?//..255
	let associations: 				Associations_Products?
	
	enum MemberKeys: String, CodingKey
	{
		case idManufacturer = 			"id_manufacturer"
		case idSupplier = 				"id_supplier"
		case idCategoryDefault = 		"id_category_default"
		case new
		case cacheDefaultAttribute = 	"cache_default_attribute"
		case idDefaultHmage = 			"id_default_image"
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
}
struct JSONProducts: Codable
{
	let products: [aProduct]?
}
