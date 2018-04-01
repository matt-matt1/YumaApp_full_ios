//
//  Order.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


protocol PropertyNames
{
	func propertyNames() -> [String]
}

extension PropertyNames
{
	func propertyNames() -> [String]
	{
		return Mirror(reflecting: self).children.compactMap { $0.label }
	}
}


struct AssociationsOrders: Decodable
{
	var order_rows: [OrderRow]
}

struct OrderRow: Decodable
{
	var id: 					String?//!
	var productId: 				String?//!
	var productAttributeId: 	String?//!
	var productQuantity: 		String?//!
	var productName: 			String?//read_only
	var productReference: 		String?//read_only
	var productEan13: 			String?//read_only
	var productIsbn: 			String?//read_only
	var productUpc: 			String?//read_only
	var productPrice: 			String?//read_only
	var unitPriceTaxIncl: 		String?//read_only
	var unitPriceTaxExcl: 		String?//read_only
	var productImage:			Data?
	
	enum MemberKeys: String, CodingKey
	{
		case id
		case productId = 			"product_id"
		case productAttributeId = 	"product_attribute_id"
		case productQuantity = 		"product_quantity"
		case productName = 			"product_name"
		case productReference = 	"product_reference"
		case productEan13 = 		"product_ean13"
		case productIsbn = 			"product_isbn"
		case productUpc = 			"product_upc"
		case productPrice = 		"product_price"
		case unitPriceTaxIncl = 	"unit_price_tax_incl"
		case unitPriceTaxExcl = 	"unit_price_tax_excl"
		case productImage
	}
}
struct Associations_OrderRows: Decodable
{
	var order_rows: [OrderRow]?
}
struct Order: Decodable, PropertyNames
{
	var id: 					Int?//!
	var idAddressDelivery: 		String?//!
	var idAddressInvoice: 		String?//!
	var idCart: 				String?//!
	var idCurrency: 			String?//!
	var idLang: 				String?//!
	var idCustomer: 			String?//!
	var idCarrier: 				String?//!
	var currentState: 			String?
	var module: 				String?//!
	var invoiceNumber: 			String?
	var invoiceDate: 			String?
	var deliveryNumber: 		String?
	var deliveryDate: 			String?
	var valid: 					String?
	var dateAdd: 				String?//date
	var dateUpd: 				String?//date
	var shippingNumber: 		String?
	var idShopGroup: 			String?
	var idShop: 				String?
	var secureKey: 				String?//md5
	var payment: 				String?//!Bool
	var recyclable: 			String?//Bool
	var gift: 					String?//Bool
	var giftMessage: 			String?
	var mobileTheme: 			String?//Bool
	var totalDiscounts: 		String?
	var totalDiscountsTaxIncl: 	String?
	var totalDiscountsTaxExcl: 	String?
	var totalPaid: 				String?//!
	var totalPaidTaxIncl: 		String?
	var totalPaidTaxExcl: 		String?
	var totalPaidReal: 			String?//!
	var totalProducts: 			String?//!
	var totalProductsWt: 		String?//!
	var totalShipping: 			String?
	var totalShippingTaxIncl: 	String?
	var totalShippingTaxExcl: 	String?
	var carrierTaxRate: 		String?//Float
	var totalWrapping: 			String?
	var totalWrappingTaxIncl: 	String?
	var totalWrappingTaxExcl: 	String?
	var roundMode: 				String?
	var roundType: 				String?
	var conversionRate: 		String?//Float
	var reference: 				String?
	var associations: 			Associations_OrderRows?
	
	enum MemberKeys: String, CodingKey
	{
		case id
		case idAddressDelivery = 		"id_address_delivery"
		case idAddressInvoice = 		"id_address_invoice"
		case idCart = 					"id_cart"
		case idCurrency = 				"id_currency"
		case idLang = 					"id_lang"
		case idCustomer = 				"id_customer"
		case idCarrier = 				"id_carrier"
		case currentState = 			"current_state"
		case module
		case invoiceNumber = 			"invoice_number"
		case invoiceDate = 				"invoice_date"
		case deliveryNumber = 			"delivery_number"
		case deliveryDate = 			"delivery_date"
		case valid
		case dateAdd = 					"date_add"
		case dateUpd = 					"date_upd"
		case shippingNumber = 			"shipping_number"
		case idShopGroup = 				"id_shop_group"
		case idShop = 					"id_shop"
		case secureKey = 				"secure_key"
		case payment
		case recyclable
		case gift
		case giftMessage = 				"gift_message"
		case mobileTheme = 				"mobile_theme"
		case totalDiscounts = 			"total_discounts"
		case totalDiscountsTaxIncl = 	"total_discounts_tax_incl"
		case totalDiscountsTaxExcl = 	"total_discounts_tax_excl"
		case totalPaid = 				"total_paid"
		case totalPaidTaxIncl = 		"total_paid_tax_incl"
		case totalPaidTaxExcl = 		"total_paid_tax_excl"
		case totalPaidReal = 			"total_paid_real"
		case totalProducts = 			"total_products"
		case totalProductsWt = 			"total_products_wt"
		case totalShipping = 			"total_shipping"
		case totalShippingTaxIncl = 	"total_shipping_tax_incl"
		case totalShippingTaxExcl = 	"total_shipping_tax_excl"
		case carrierTaxRate = 			"carrier_tax_rate"
		case totalWrapping = 			"total_wrapping"
		case totalWrappingTaxIncl = 	"total_wrapping_tax_incl"
		case totalWrappingTaxExcl = 	"total_wrapping_tax_excl"
		case roundMode = 				"round_mode"
		case roundType = 				"round_type"
		case conversionRate = 			"conversion_rate"
		case reference
		case associations
	}
}
struct Orders
{
	let orders: [Order]?
}
