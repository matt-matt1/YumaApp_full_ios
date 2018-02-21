//
//  ProductsMyFeeder.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation

struct ProdImage: Decodable
{
	let title: String?
	let url: String?
	let link: String?
}

struct Ecotax: Decodable
{
	let value: String?
	let amount: String?
	let rate: String?//Int
}

struct SmallDefault: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct CartDefault: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct HomeDefault: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct MediumDefault: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct LargeDefault: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct BySize: Decodable
{
	let small_default: [SmallDefault]?
	let cart_default: [CartDefault]?
	let home_default: [HomeDefault]?
	let medium_default: [MediumDefault]?
	let large_default: [LargeDefault]?
}

struct Small: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Medium: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Large: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Image2: Decodable
{
	let bySize: [BySize]?
	let small: [Small]?
	let medium: [Medium]?
	let large: [Large]?
	let legend: String?//AnyString
	let cover: String?
	let id_image: String?
	let position: String?
	let associatedVariants: [String]?
}

struct SmallDefault2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct CartDefault2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct HomeDefault2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct MediumDefault2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct LargeDefault2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct BySize2: Decodable
{
	let small_default: [SmallDefault2]?
	let cart_default: [CartDefault2]?
	let home_default: [HomeDefault2]?
	let medium_default: [MediumDefault2]?
	let large_default: [LargeDefault2]?
}

struct Small2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Medium2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Large2: Decodable
{
	let url: String?
	let width: String?//Int
	let height: String?//Int
}

struct Cover: Decodable
{
	let bySize: [BySize2]?
	let small: [Small2]?
	let medium: [Medium2]?
	let large: [Large2]?
	let legend: String?//AnyString
	let cover: String?
	let id_image: String?
	let position: String?
	let associatedVariants: [String]?
}

struct Labels: Decodable
{
	let tax_short: String?
	let tax_long: String?
}

struct __invalid_type__4: Decodable
{
	let id_attribute: String?
	let id_attribute_group: String?
	let name: String?
	let group: String?
	let reference: String?//AnyString
	let ean13: String?//AnyString
	let isbn: String?//AnyString
	let upc: String?//AnyString
}

struct Attributes: Decodable
{
	let __invalid_name__4: [__invalid_type__4]?
}

struct EmbeddedAttributes: Decodable
{
	let id_product: String?
	let id_supplier: String?
	let id_manufacturer: String?
	let id_category_default: String?
	let id_shop_default: String?
	let on_sale: String?
	let online_only: String?
	let ecotax: String?
	let quantity: String?//Int
	let minimal_quantity: String?
	let price: String?//Double
	let unity: String?
	let unit_price_ratio: String?
	let additional_shipping_cost: String?
	let reference: String?
	let out_of_stock: String?
	let customizable: String?
	let uploadable_files: String?
	let text_fields: String?
	let redirect_type: String?
	let id_type_redirected: String?
	let available_for_order: String?
	let available_date: String?
	let show_condition: String?
	let condition: String?
	let show_price: String?
	let indexed: String?
	let visibility: String?
	let is_virtual: String?
	let cache_default_attribute: String?
	let date_add: String?
	let date_upd: String?
	let advanced_stock_management: String?
	let pack_stock_type: String?
	let id_product_attribute: String?//AnyString
	let description: String?
	let description_short: String?
	let available_now: String?
	let available_later: String?
	let link_rewrite: String?
	let meta_description: String?//AnyString
	let meta_keywords: String?
	let meta_title: String?//AnyString
	let name: String?
	let id_image: String?
	let new: String?
	let allow_oosp: String?//Int
	let category: String?
	let category_name: String?
	let link: String?
	let attribute_price: String?//Int
	let price_tax_exc: String?//Double
	let price_without_reduction: String?//Double
	let reduction: String?//Int
	let specific_prices: [String]?
	let quantity_all_versions: String?//Int
	let features: [String]?
	let attachments: [String]?
	let virtual: String?//Int
	let pack: String?//Int
	let packItems: [String]?
	let nopackprice: String?//Int
	let customization_required: String?//Bool
	let attributes: [Attributes]
	let rate: String?//Int
	let tax_name: String?
	let ecotax_rate: String?//Int
	let unit_price: String?//Int
}

struct FeedProduct: Decodable
{
	let id_product: String?
	let id_supplier: String?
	let id_manufacturer: String?
	let id_category_default: String?
	let id_shop_default: String?
	let id_tax_rules_group: String?
	let on_sale: String?
	let online_only: String?
	let ean13: String?
	let isbn: String?
	let upc: String?
	let ecotax: Ecotax
	let quantity: String?//Int
	let minimal_quantity: String?
	let price: String?
	let wholesale_price: String?
	let unity: String?
	let unit_price_ratio: String?
	let additional_shipping_cost: String?
	let reference: String?
	let supplier_reference: String?
	let location: String?
	let width: String?
	let height: String?
	let depth: String?
	let weight: String?
	let out_of_stock: String?
	let quantity_discount: String?
	let customizable: String?
	let uploadable_files: String?
	let text_fields: String?
	let active: String?
	let redirect_type: String?
	let id_type_redirected: String?
	let available_for_order: String?
	let available_date: String?
	let show_condition: String?
	let condition: String?//AnyString
	let show_price: String?//Bool
	let indexed: String?
	let visibility: String?
	let cache_is_pack: String?
	let cache_has_attachments: String?
	let is_virtual: String?
	let cache_default_attribute: String?
	let date_add: String?
	let date_upd: String?
	let advanced_stock_management: String?
	let pack_stock_type: String?
	let state: String?
	let id_shop: String?
	let id_product_attribute: String?//AnyString
	let product_attribute_minimal_quantity: String?
	let description: String?
	let description_short: String?
	let available_now: String?
	let available_later: String?
	let link_rewrite: String?
	let meta_description: String?//AnyString
	let meta_keywords: String?
	let meta_title: String?//AnyString
	let name: String?
	let id_image: String?
	let legend: String?//AnyString
	let manufacturer_name: String?
	let category_default: String?
	let new: String?
	let orderprice: String?
	let allow_oosp: String?//Int
	let category: String?
	let category_name: String?
	let link: String?
	let attribute_price: String?//Int
	let price_tax_exc: String?//Double
	let price_without_reduction: String?//Double
	let reduction: String?//Int
	let specific_prices: [String]?
	let quantity_all_versions: String?//Int
	let features: [String]?
	let attachments: [String]?
	let virtual: String?//Int
	let pack: String?//Int
	let packItems: [String]?
	let nopackprice: String?//Int
	let customization_required: String?//Bool
	let attributes: String?//AnyString
	let rate: String?//Int
	let tax_name: String?
	let ecotax_rate: String?//Int
	let unit_price: String?
	let id_lang: String?
	let id: String?
	let weight_unit: String?
	let images: [Image2]
	let cover: [Cover]
	let url: String?
	let canonical_url: String?
	let has_discount: String?//Bool
	let discount_type: String?//AnyString
	let discount_percentage: String?//AnyString
	let discount_percentage_absolute: String?//AnyString
	let discount_amount: String?//AnyString
	let price_amount: String?//Double
	let regular_price_amount: String?//Double
	let regular_price: String?
	let discount_to_display: String?
	let unit_price_full: String?
	let add_to_cart_url: String?
	let main_variants: [String]?
	let flags: [String]?
	let labels: [Labels]
	let show_availability: String?//Bool
	let availability_message: String?
	let availability_date: String?//AnyString
	let availability: String?
	let quantity_discounts: [String]?
	let reference_to_display: String?//AnyString
	let embedded_attributes: [EmbeddedAttributes]
}

struct Shop: Decodable
{
	let title: String?
	let description: String?
	let link: String?
	let generator: String?
	let webMaster: String?
	let language: String?
	let image: ProdImage?
	let id_category: String?
	let n_products: String?
	let products: [FeedProduct]
}

struct MyShops: Decodable
{
	let shop: Shop
}

//enum CodingKeys: String, CodingKey
//{
//	case <#case#>
//}

