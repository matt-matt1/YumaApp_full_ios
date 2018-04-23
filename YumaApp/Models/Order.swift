//
//  Order.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct AssociationsOrders: Decodable
{
	var order_rows: [OrderRow]
}

//struct OrderRow: Decodable
//{
//	var id: 					String?//!
//	var productId: 				String?//!
//	var productAttributeId: 	String?//!
//	var productQuantity: 		String?//!
//	var productName: 			String?//read_only
//	var productReference: 		String?//read_only
//	var productEan13: 			String?//read_only
//	var productIsbn: 			String?//read_only
//	var productUpc: 			String?//read_only
//	var productPrice: 			String?//read_only
//	var unitPriceTaxIncl: 		String?//read_only
//	var unitPriceTaxExcl: 		String?//read_only
//	var productImage:			Data?
//
//	enum MemberKeys: String, CodingKey
//	{
//		case id
//		case productId = 			"product_id"
//		case productAttributeId = 	"product_attribute_id"
//		case productQuantity = 		"product_quantity"
//		case productName = 			"product_name"
//		case productReference = 	"product_reference"
//		case productEan13 = 		"product_ean13"
//		case productIsbn = 			"product_isbn"
//		case productUpc = 			"product_upc"
//		case productPrice = 		"product_price"
//		case unitPriceTaxIncl = 	"unit_price_tax_incl"
//		case unitPriceTaxExcl = 	"unit_price_tax_excl"
//		case productImage
//	}
//}
struct OrderRow: Decodable
{
	var id: 					String?//!
	var product_id: 			String?//!
	var product_attribute_id: 	String?//!
	var product_quantity: 		String?//!
	var product_name: 			String?//read_only
	var product_reference: 		String?//read_only
	var product_ean13: 			String?//read_only
	var product_isbn: 			String?//read_only
	var product_upc: 			String?//read_only
	var product_price: 			String?//read_only
	var unit_price_tax_incl: 	String?//read_only
	var unit_price_tax_excl: 	String?//read_only
	var productImage:			Data?
}
struct OrdersAssociations: Decodable
{
	var order_rows: [OrderRow]?
}
//struct Order: Decodable, PropertyNames
//{
//	var id: 					Int?//!
//	var idAddressDelivery: 		String?//!
//	var idAddressInvoice: 		String?//!
//	var idCart: 				String?//!
//	var idCurrency: 			String?//!
//	var idLang: 				String?//!
//	var idCustomer: 			String?//!
//	var idCarrier: 				String?//!
//	var currentState: 			String?
//	var module: 				String?//!
//	var invoiceNumber: 			String?
//	var invoiceDate: 			String?
//	var deliveryNumber: 		String?
//	var deliveryDate: 			String?
//	var valid: 					String?
//	var dateAdd: 				String?//date
//	var dateUpd: 				String?//date
//	var shippingNumber: 		String?
//	var idShopGroup: 			String?
//	var idShop: 				String?
//	var secureKey: 				String?//md5
//	var payment: 				String?//!Bool
//	var recyclable: 			String?//Bool
//	var gift: 					String?//Bool
//	var giftMessage: 			String?
//	var mobileTheme: 			String?//Bool
//	var totalDiscounts: 		String?
//	var totalDiscountsTaxIncl: 	String?
//	var totalDiscountsTaxExcl: 	String?
//	var totalPaid: 				String?//!
//	var totalPaidTaxIncl: 		String?
//	var totalPaidTaxExcl: 		String?
//	var totalPaidReal: 			String?//!
//	var totalProducts: 			String?//!
//	var totalProductsWt: 		String?//!
//	var totalShipping: 			String?
//	var totalShippingTaxIncl: 	String?
//	var totalShippingTaxExcl: 	String?
//	var carrierTaxRate: 		String?//Float
//	var totalWrapping: 			String?
//	var totalWrappingTaxIncl: 	String?
//	var totalWrappingTaxExcl: 	String?
//	var roundMode: 				String?
//	var roundType: 				String?
//	var conversionRate: 		String?//Float
//	var reference: 				String?
//	var associations: 			Associations_OrderRows?
//
//	enum MemberKeys: String, CodingKey
//	{
//		case id
//		case idAddressDelivery = 		"id_address_delivery"
//		case idAddressInvoice = 		"id_address_invoice"
//		case idCart = 					"id_cart"
//		case idCurrency = 				"id_currency"
//		case idLang = 					"id_lang"
//		case idCustomer = 				"id_customer"
//		case idCarrier = 				"id_carrier"
//		case currentState = 			"current_state"
//		case module
//		case invoiceNumber = 			"invoice_number"
//		case invoiceDate = 				"invoice_date"
//		case deliveryNumber = 			"delivery_number"
//		case deliveryDate = 			"delivery_date"
//		case valid
//		case dateAdd = 					"date_add"
//		case dateUpd = 					"date_upd"
//		case shippingNumber = 			"shipping_number"
//		case idShopGroup = 				"id_shop_group"
//		case idShop = 					"id_shop"
//		case secureKey = 				"secure_key"
//		case payment
//		case recyclable
//		case gift
//		case giftMessage = 				"gift_message"
//		case mobileTheme = 				"mobile_theme"
//		case totalDiscounts = 			"total_discounts"
//		case totalDiscountsTaxIncl = 	"total_discounts_tax_incl"
//		case totalDiscountsTaxExcl = 	"total_discounts_tax_excl"
//		case totalPaid = 				"total_paid"
//		case totalPaidTaxIncl = 		"total_paid_tax_incl"
//		case totalPaidTaxExcl = 		"total_paid_tax_excl"
//		case totalPaidReal = 			"total_paid_real"
//		case totalProducts = 			"total_products"
//		case totalProductsWt = 			"total_products_wt"
//		case totalShipping = 			"total_shipping"
//		case totalShippingTaxIncl = 	"total_shipping_tax_incl"
//		case totalShippingTaxExcl = 	"total_shipping_tax_excl"
//		case carrierTaxRate = 			"carrier_tax_rate"
//		case totalWrapping = 			"total_wrapping"
//		case totalWrappingTaxIncl = 	"total_wrapping_tax_incl"
//		case totalWrappingTaxExcl = 	"total_wrapping_tax_excl"
//		case roundMode = 				"round_mode"
//		case roundType = 				"round_type"
//		case conversionRate = 			"conversion_rate"
//		case reference
//		case associations
//	}
//}
struct Order: Decodable, PropertyNames
{
//	func propertyNames() -> [String] {
//		<#code#>
//	}
	
	var id: 						Int?//!
	var id_address_delivery: 		String?//!
	var id_address_invoice: 		String?//!
	var id_cart: 					String?//!
	var id_currency: 				String?//!
	var id_lang: 					String?//!
	var id_customer: 				String?//!
	var id_carrier: 				String?//!
	var current_state: 				String?
	var module: 					String?//!
	var invoice_number: 			String?
	var invoice_date: 				String?
	var delivery_number: 			String?
	var delivery_date: 				String?
	var valid: 						String?
	var date_add: 					String?//date
	var date_upd: 					String?//date
	var shipping_number: 			String?
	var id_shop_group: 				String?
	var id_shop: 					String?
	var secure_key: 				String?//md5
	var payment: 					String?//!Bool
	var recyclable: 				String?//Bool
	var gift: 						String?//Bool
	var gift_message: 				String?
	var mobile_theme: 				String?//Bool
	var total_discounts: 			String?
	var total_discounts_tax_incl: 	String?
	var total_discounts_tax_excl: 	String?
	var total_paid: 				String?//!
	var total_paid_tax_incl: 		String?
	var total_paid_tax_excl: 		String?
	var total_paid_real: 			String?//!
	var total_products: 			String?//!
	var total_products_wt: 			String?//!
	var total_shipping: 			String?
	var total_shipping_tax_incl: 	String?
	var total_shipping_tax_excl: 	String?
	var carrier_tax_rate: 			String?//Float
	var total_wrapping: 			String?
	var total_wrapping_tax_incl: 	String?
	var total_wrapping_tax_excl: 	String?
	var round_mode: 				String?
	var round_type: 				String?
	var conversion_rate: 			String?//Float
	var reference: 					String?
	var associations: 				OrdersAssociations?
}
struct Orders: Decodable
{
	let orders: [Order]?
}
