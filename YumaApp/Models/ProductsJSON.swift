//
//  ProductsJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct MetaDescription: Decodable
{
	let id: String?
	let value: String?//AnyObject
}

struct MetaKeyword: Decodable
{
	let id: String?
	let value: String?//AnyObject
}

struct MetaTitle: Decodable
{
	let id: String?
	let value: String?//AnyObject
}

struct LinkRewrite: Decodable
{
	let id: String?
	let value: String?
}

struct Name: Decodable
{
	let id: String?
	let value: String?
}

struct Description: Decodable
{
	let id: String?
	let value: String?
}

struct DescriptionShort: Decodable
{
	let id: String?
	let value: String?
}

struct AvailableNow: Decodable
{
	let id: String?
	let value: String?//AnyObject
}

struct AvailableLater: Decodable
{
	let id: String?
	let value: String?//AnyObject
}

struct Category: Decodable
{
	let id: String?
}

struct Image: Decodable
{
	let id: String?
}

struct Combination: Decodable
{
	let id: String?
}

struct ProductOptionValue: Decodable
{
	let id: String?
}

struct Tag: Decodable
{
	let id: String?
}

struct StockAvailable: Decodable
{
	let id: String?
	let id_product_attribute: String?
}

struct AssociationsProducts: Decodable
{
	let categories: [Category]?
	let images: [Image]?
	let combinations: [Combination]?
	let product_option_values: [ProductOptionValue]?
	let tags: [Tag]?
	let stock_availables: [StockAvailable]?
}

struct aProduct: Decodable
{
	let id: Int?
	let id_manufacturer: String?
	let id_supplier: String?
	let id_category_default: String?
	let new: String?//AnyObject
	let cache_default_attribute: String?
	let id_default_image: String?
	let id_default_combination: String?
	//^
	//...Int?:Expected to decode Int but found a string/data instead
	//...String?:Expected to decode String but found a number instead
	let id_tax_rules_group: String?
	let position_in_category: String?
	let manufacturer_name: String?
	let quantity: String?
	let type: String?
	let id_shop_default: String?
	let reference: String?//AnyObject
	let supplier_reference: String?//AnyObject
	let location: String?//AnyObject
	let width: String?
	let height: String?
	let depth: String?
	let weight: String?
	let quantity_discount: String?
	let ean13: String?//AnyObject
	let isbn: String?//AnyObject
	let upc: String?//AnyObject
	let cache_is_pack: String?
	let cache_has_attachments: String?
	let is_virtual: String?
	let state: String?
	let on_sale: String?
	let online_only: String?
	let ecotax: String?
	let minimal_quantity: String?
	let price: String?
	let wholesale_price: String?
	let unity: String?//AnyObject
	let unit_price_ratio: String?
	let additional_shipping_cost: String?
	let customizable: String?
	let text_fields: String?
	let uploadable_files: String?
	let active: String?
	let redirect_type: String?
	let id_type_redirected: String?
	let available_for_order: String?
	let available_date: String?
	let show_condition: String?
	let condition: String?
	let show_price: String?
	let indexed: String?
	let visibility: String?
	let advanced_stock_management: String?
	let date_add: String?
	let date_upd: String?
	let pack_stock_type: String?
	let meta_description: [MetaDescription]?
	let meta_keywords: [MetaKeyword]?
	let meta_title: [MetaTitle]?
	let link_rewrite: [LinkRewrite]?
	let name: [Name]?
	let description: [Description]?
	let description_short: [DescriptionShort]?
	let available_now: [AvailableNow]?
	let available_later: [AvailableLater]?
	let associations: AssociationsProducts?
}

struct JSONProducts: Decodable
{
	let products: [aProduct]?
}
