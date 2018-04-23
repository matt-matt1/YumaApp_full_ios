//
//  Carts.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CartRow: Decodable
{
	var idProduct: 				String?
	var idProductAttribute: 	String?
	var idAddressDelivery: 		String?
	var quantity: 				String?
	
	enum MemberKeys: String, CodingKey
	{
		case idProduct = 			"id_product"
		case idProductAttribute = 	"id_product_attribute"
		case idAddressDelivery = 	"id_address_delivery"
		case quantity
	}
}
struct CartAssociations: Decodable
{
	let cart_rows: [CartRow]?
}
struct aCart: Decodable
{
	var id: 					Int?
	var idAddressDelivery: 		String?
	var idAddressInvoice: 		String?
	var idCurrency: 			String?
	var idCustomer: 			String?
	var idGuest: 				String?
	var idLang: 				String?
	var idShopGroup: 			String?
	var idShop: 				String?
	var idCarrier: 				String?
	var recyclable: 			String?//Bool
	var gift: 					String?//Bool
	var giftMessage: 			String?
	var mobileTheme: 			String?//Bool
	var deliveryOption: 		String?
	var secureKey: 				String?//..32
	var allowSeperatedPackage: 	String?//Bool
	var dateAdd: 				String?//date
	var dateUpd: 				String?//date
	var associations: 			CartAssociations?
	
	enum MemberKeys: String, CodingKey
	{
		case id
		case idAddressDelivery = 		"id_address_delivery"
		case idAddressInvoice = 		"id_address_invoice"
		case idCurrency = 				"id_currency"
		case idCustomer = 				"id_customer"
		case idGuest = 					"id_guest"
		case idLang = 					"id_lang"
		case idShopGroup = 				"id_shop_group"
		case idShop = 					"id_shop"
		case idCarrier = 				"id_carrier"
		case recyclable
		case gift
		case giftMessage = 				"gift_message"
		case mobileTheme = 				"mobile_theme"
		case deliveryOption = 			"delivery_option"
		case secureKey = 				"secure_key"
		case allowSeperatedPackage = 	"allow_seperated_package"
		case dateAdd = 					"date_add"
		case dateUpd = 					"date_upd"
		case associations
		case cartRows = 				"cart_rows"
	}
}
struct Carts: Decodable
{
	let carts: [aCart]?
}
