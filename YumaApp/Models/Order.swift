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

struct OrderRow: Decodable
{
	var id: 					Int?//!
	var productId: 				Int?//!
	var productAttributeId: 	Int?//!
	var productQuantity: 		Int?//!
	var productName: 			String?//read_only
	var productReference: 		String?//read_only
	var productEan13: 			String?//read_only
	var productIsbn: 			String?//read_only
	var productUpc: 			String?//read_only
	var productPrice: 			Float?//read_only
	var unitPriceTaxIncl: 		Float?//read_only
	var unitPriceTaxExcl: 		Float?//read_only
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
//struct OrderRow: Decodable
//{
//	var id: 					String?//!
//	var product_id: 			String?//!
//	var product_attribute_id: 	String?//!
//	var product_quantity: 		String?//!
//	var product_name: 			String?//read_only
//	var product_reference: 		String?//read_only
//	var product_ean13: 			String?//read_only
//	var product_isbn: 			String?//read_only
//	var product_upc: 			String?//read_only
//	var product_price: 			String?//read_only
//	var unit_price_tax_incl: 	String?//read_only
//	var unit_price_tax_excl: 	String?//read_only
//	var productImage:			Data?
//}
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
	
	var id: 					Int?//!/
	var idAddressDelivery: 		Int?//!/
	var idAddressInvoice: 		Int?//!/
	var idCart: 				Int?//!/
	var idCurrency: 			Int?//!/
	var idLang: 				Int?//!/
	var idCustomer: 			Int?//!/
	var idCarrier: 				Int?//!/
	var currentState: 			Int?///
	var module: 				String?//!/
	var invoiceNumber: 			String?///
	var invoiceDate: 			Date?///
	var deliveryNumber: 		String?///
	var deliveryDate: 			Date?///
	var valid: 					Int?///
	var dateAdd: 				Date?//date/
	var dateUpd: 				Date?//date/
	var shippingNumber: 		String?///
	var idShopGroup: 			Int?///
	var idShop: 				Int?///
	var secureKey: 				String?//md5/
	var payment: 				String?
	var recyclable: 			Bool?//Bool
	var gift: 					Bool?//Bool
	var giftMessage: 			String?
	var mobileTheme: 			Bool?//Bool
	var totalDiscounts: 		Float?
	var totalDiscountsTaxIncl: 	Float?
	var totalDiscountsTaxExcl: 	Float?
	var totalPaid: 				Float?//!
	var totalPaidTaxIncl: 		Float?
	var totalPaidTaxExcl: 		Float?
	var totalPaidReal: 			Float?//!
	var totalProducts: 			Int?//!
	var totalProductsWt: 		Float?//!
	var totalShipping: 			Float?
	var totalShippingTaxIncl: 	Float?
	var totalShippingTaxExcl: 	Float?
	var carrierTaxRate: 		Float?//Float
	var totalWrapping: 			Float?
	var totalWrappingTaxIncl: 	Float?
	var totalWrappingTaxExcl: 	Float?
	var roundMode: 				Int?
	var roundType: 				Int?
	var conversionRate: 		Float?//Float
	var reference: 				String?
	var associations: 			OrdersAssociations?
	
	enum CodingKeys: String, CodingKey
	{
		case id
		case idAddressDelivery = "id_address_delivery"
		case idAddressInvoice = "id_address_invoice"
		case idCart = "id_cart"
		case idCurrency = "id_currency"
		case idLang = "id_lang"
		case idCustomer = "id_customer"
		case idCarrier = "id_carrier"
		case currentState = "current_state"
		case module
		case invoiceNumber = "invoice_number"
		case invoiceDate = "invoice_date"
		case deliveryNumber = "delivery_number"
		case deliveryDate = "delivery_date"
		case valid
		case dateAdd = "date_add"
		case dateUpd = "date_upd"
		case shippingNumber = "shipping_number"
		case idShopGroup = "id_shop_group"
		case idShop = "id_shop"
		case secureKey = "secure_key"
		case payment
		case recyclable
		case gift
		case giftMessage = "gift_message"
		case mobileTheme = "mobile_theme"
		case totalDiscounts = "total_discounts"
		case totalDiscountsTaxIncl = "total_discounts_tax_incl"
		case totalDiscountsTaxExcl = "total_discounts_tax_excl"
		case totalPaid = "total_paid"
		case totalPaidTaxIncl = "total_paid_tax_incl"
		case totalPaidTaxExcl = "total_paid_tax_excl"
		case totalPaidReal = "total_paid_real"
		case totalProducts = "total_products"
		case totalProductsWt = "total_products_wt"
		case totalShipping = "total_shipping"
		case totalShippingTaxIncl = "total_shipping_tax_incl"
		case totalShippingTaxExcl = "total_shipping_tax_excl"
		case carrierTaxRate = "carrier_tax_rate"
		case totalWrapping = "total_wrapping"
		case totalWrappingTaxIncl = "total_wrapping_tax_incl"
		case totalWrappingTaxExcl = "total_wrapping_tax_excl"
		case roundMode = "round_mode"
		case roundType = "round_type"
		case conversionRate = "conversion_rate"
		case reference
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
		idAddressDelivery = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idAddressDelivery)
		{
			idAddressDelivery = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idAddressDelivery)
		{
			idAddressDelivery = Int(str)
		}
		idAddressInvoice = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idAddressInvoice)
		{
			idAddressInvoice = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idAddressInvoice)
		{
			idAddressInvoice = Int(str)
		}
		idCart = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCart)
		{
			idCart = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCart)
		{
			idCart = Int(str)
		}
		idCurrency = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCurrency)
		{
			idCurrency = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCurrency)
		{
			idCurrency = Int(str)
		}
		idLang = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idLang)
		{
			idLang = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idLang)
		{
			idLang = Int(str)
		}
		idCustomer = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCustomer)
		{
			idCustomer = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCustomer)
		{
			idCustomer = Int(str)
		}
		idCarrier = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCarrier)
		{
			idCarrier = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idCarrier)
		{
			idCarrier = Int(str)
		}
		currentState = 0
		if let myInt = try? parent.decode(Int.self, forKey: .currentState)
		{
			currentState = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .currentState)
		{
			currentState = Int(str)
		}
		module = ""
		if let myInt = try? parent.decode(String.self, forKey: .module)
		{
			module = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .module)
		{
			module = ""
		}
		invoiceNumber = ""
		if let myInt = try? parent.decode(String.self, forKey: .invoiceNumber)
		{
			invoiceNumber = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .invoiceNumber)
		{
			invoiceNumber = ""
		}
		invoiceDate = nil
		if let myInt = try? parent.decode(Date.self, forKey: .invoiceDate)
		{
			invoiceDate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .invoiceDate)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			invoiceDate = df.date(from: str)
		}
		deliveryNumber = ""
		if let myInt = try? parent.decode(String.self, forKey: .deliveryNumber)
		{
			deliveryNumber = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .deliveryNumber)
		{
			deliveryNumber = ""
		}
		deliveryDate = nil
		if let myInt = try? parent.decode(Date.self, forKey: .deliveryDate)
		{
			deliveryDate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .deliveryDate)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			deliveryDate = df.date(from: str)
		}
		valid = 0
		if let myInt = try? parent.decode(Int.self, forKey: .valid)
		{
			valid = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .valid)
		{
			valid = Int(str)
		}
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
		shippingNumber = ""
		if let myInt = try? parent.decode(String.self, forKey: .shippingNumber)
		{
			shippingNumber = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .shippingNumber)
		{
			shippingNumber = ""
		}
		idShopGroup = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShopGroup)
		{
			idShopGroup = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idShopGroup)
		{
			idShopGroup = Int(str)
		}
		idShop = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShop)
		{
			idShop = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idShop)
		{
			idShop = Int(str)
		}
		secureKey = ""
		if let myInt = try? parent.decode(String.self, forKey: .secureKey)
		{
			secureKey = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .secureKey)
		{
			secureKey = ""
		}
		payment = ""
		if let myInt = try? parent.decode(String.self, forKey: .payment)
		{
			payment = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .payment)
		{
			payment = ""
		}
		recyclable = false
		if let myInt = try? parent.decode(Bool.self, forKey: .recyclable)
		{
			recyclable = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .recyclable)
		{
			recyclable = str != "0"
		}
		gift = false
		if let myInt = try? parent.decode(Bool.self, forKey: .gift)
		{
			gift = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .gift)
		{
			gift = str != "0"
		}
		giftMessage = ""
		if let myInt = try? parent.decode(String.self, forKey: .giftMessage)
		{
			giftMessage = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .giftMessage)
		{
			giftMessage = ""
		}
		mobileTheme = false
		if let myInt = try? parent.decode(Bool.self, forKey: .mobileTheme)
		{
			mobileTheme = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .mobileTheme)
		{
			mobileTheme = str != "0"
		}
		totalDiscounts = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalDiscounts)
		{
			totalDiscounts = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalDiscounts)
		{
			totalDiscounts = Float(str)
		}
		totalDiscountsTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalDiscountsTaxIncl)
		{
			totalDiscountsTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalDiscountsTaxIncl)
		{
			totalDiscountsTaxIncl = Float(str)
		}
		totalDiscountsTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalDiscountsTaxExcl)
		{
			totalDiscountsTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalDiscountsTaxExcl)
		{
			totalDiscountsTaxExcl = Float(str)
		}
		totalPaid = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalPaid)
		{
			totalPaid = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalPaid)
		{
			totalPaid = Float(str)
		}
		totalPaidTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalPaidTaxIncl)
		{
			totalPaidTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalPaidTaxIncl)
		{
			totalPaidTaxIncl = Float(str)
		}
		totalPaidTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalPaidTaxExcl)
		{
			totalPaidTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalPaidTaxExcl)
		{
			totalPaidTaxExcl = Float(str)
		}
		totalPaidReal = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalPaidReal)
		{
			totalPaidReal = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalPaidReal)
		{
			totalPaidReal = Float(str)
		}
		totalProducts = 0
		if let myInt = try? parent.decode(Int.self, forKey: .totalProducts)
		{
			totalProducts = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalProducts)
		{
			totalProducts = Int(str)
		}
		totalProductsWt = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalProductsWt)
		{
			totalProductsWt = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalProductsWt)
		{
			totalProductsWt = Float(str)
		}
		totalShipping = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalShipping)
		{
			totalShipping = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalShipping)
		{
			totalShipping = Float(str)
		}
		totalShippingTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalShippingTaxIncl)
		{
			totalShippingTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalShippingTaxIncl)
		{
			totalShippingTaxIncl = Float(str)
		}
		totalShippingTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalShippingTaxExcl)
		{
			totalShippingTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalShippingTaxExcl)
		{
			totalShippingTaxExcl = Float(str)
		}
		carrierTaxRate = 0
		if let myInt = try? parent.decode(Float.self, forKey: .carrierTaxRate)
		{
			carrierTaxRate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .carrierTaxRate)
		{
			carrierTaxRate = Float(str)
		}
		totalWrapping = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalWrapping)
		{
			totalWrapping = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalWrapping)
		{
			totalWrapping = Float(str)
		}
		totalWrappingTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalWrappingTaxIncl)
		{
			totalWrappingTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalWrappingTaxIncl)
		{
			totalWrappingTaxIncl = Float(str)
		}
		totalWrappingTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalWrappingTaxExcl)
		{
			totalWrappingTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalWrappingTaxExcl)
		{
			totalWrappingTaxExcl = Float(str)
		}
		roundMode = 0
		if let myInt = try? parent.decode(Int.self, forKey: .roundMode)
		{
			roundMode = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .roundMode)
		{
			roundMode = Int(str)
		}
		roundType = 0
		if let myInt = try? parent.decode(Int.self, forKey: .roundType)
		{
			roundType = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .roundType)
		{
			roundType = Int(str)
		}
		conversionRate = 0
		if let myInt = try? parent.decode(Float.self, forKey: .conversionRate)
		{
			conversionRate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .conversionRate)
		{
			conversionRate = Float(str)
		}
		reference = ""
		if let myInt = try? parent.decode(String.self, forKey: .reference)
		{
			reference = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .reference)
		{
			reference = ""
		}
		associations = try parent.decode(OrdersAssociations.self, forKey: .associations)
	}
	init(id: Int?, idAddressDelivery: Int?, idAddressInvoice: Int?, idCart: Int?, idCurrency: Int?, idLang: Int?, idCustomer: Int?, idCarrier: Int?, currentState: Int?, module: String?, invoiceNumber: String?, invoiceDate: Date?, deliveryNumber: String?, deliveryDate: Date?, valid: Int?, dateAdd: Date?, dateUpd: Date?, shippingNumber: String?, idShopGroup: Int?, idShop: Int?, secureKey: String?, payment: String?, recyclable: Bool?, gift: Bool?, giftMessage: String?, mobileTheme: Bool?, totalDiscounts: Float?, totalDiscountsTaxIncl: Float?, totalDiscountsTaxExcl: Float?, totalPaid: Float?, totalPaidTaxIncl: Float?, totalPaidTaxExcl: Float?, totalPaidReal: Float?, totalProducts: Int?, totalProductsWt: Float?, totalShipping: Float?, totalShippingTaxIncl: Float?, totalShippingTaxExcl: Float?, carrierTaxRate: Float?, totalWrapping: Float?, totalWrappingTaxIncl: Float?, totalWrappingTaxExcl: Float?, roundMode: Int?, roundType: Int?, conversionRate: Float?, reference: String?, associations: OrdersAssociations?) {
	self.id = id
	self.idAddressDelivery = idAddressDelivery
	self.idAddressInvoice = idAddressInvoice
	self.idCart = idCart
	self.idCurrency = idCurrency
	self.idLang = idLang
	self.idCustomer = idCustomer
	self.idCarrier = idCarrier
	self.currentState = currentState
	self.module = module
	self.invoiceNumber = invoiceNumber
	self.invoiceDate = invoiceDate
	self.deliveryNumber = deliveryNumber
	self.deliveryDate = deliveryDate
	self.valid = valid
	self.dateAdd = dateAdd
	self.dateUpd = dateUpd
	self.shippingNumber = shippingNumber
	self.idShopGroup = idShopGroup
	self.idShop = idShop
	self.secureKey = secureKey
	self.payment = payment
	self.recyclable = recyclable
	self.gift = gift
	self.giftMessage = giftMessage
	self.mobileTheme = mobileTheme
	self.totalDiscounts = totalDiscounts
	self.totalDiscountsTaxIncl = totalDiscountsTaxIncl
	self.totalDiscountsTaxExcl = totalDiscountsTaxExcl
	self.totalPaid = totalPaid
	self.totalPaidTaxIncl = totalPaidTaxIncl
	self.totalPaidTaxExcl = totalPaidTaxExcl
	self.totalPaidReal = totalPaidReal
	self.totalProducts = totalProducts
	self.totalProductsWt = totalProductsWt
	self.totalShipping = totalShipping
	self.totalShippingTaxIncl = totalShippingTaxIncl
	self.totalShippingTaxExcl = totalShippingTaxExcl
	self.carrierTaxRate = carrierTaxRate
	self.totalWrapping = totalWrapping
	self.totalWrappingTaxIncl = totalWrappingTaxIncl
	self.totalWrappingTaxExcl = totalWrappingTaxExcl
	self.roundMode = roundMode
	self.roundType = roundType
	self.conversionRate = conversionRate
	self.reference = reference
	self.associations = associations

	}
}
struct Orders: Decodable
{
	let orders: [Order]?
}
