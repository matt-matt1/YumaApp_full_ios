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
	var idProduct: 				Int?//String?
	var idProductAttribute: 	Int?//String?
	var idAddressDelivery: 		Int?//String?
	var quantity: 				Int?//String?
	
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
	var idAddressDelivery: 		Int?//String?
	var idAddressInvoice: 		Int?//String?
	var idCurrency: 			Int?//String?
	var idCustomer: 			Int?//String?
	var idGuest: 				Int?//String?
	var idLang: 				Int?//String?
	var idShopGroup: 			Int?//String?
	var idShop: 				Int?//String?
	var idCarrier: 				Int?//String?
	var recyclable: 			Bool?//String?//Bool
	var gift: 					Bool?//String?//Bool
	var giftMessage: 			String?
	var mobileTheme: 			Bool?//String?//Bool
	var deliveryOption: 		String?
	var secureKey: 				Int32?//String?//..32
	var allowSeperatedPackage: 	Bool?//String?//Bool
	var dateAdd: 				String?//date
	var dateUpd: 				String?//date
	var associations: 			CartAssociations?
	
	enum CodingKeys: String, CodingKey
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
	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myNull = try? parent.decodeNil(forKey: .id)
		{
			if !myNull
			{
				if let myInt = try? parent.decode(UInt.self, forKey: .id)			{	id = Int(myInt)			}
				else if let myInt = try? parent.decode(Int.self, forKey: .id)		{	id = myInt				}
				else if let str = try? parent.decode(String.self, forKey: .id)		{	id = Int(str)!			}
			}
		}
		idAddressDelivery = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idAddressDelivery)		{	idAddressDelivery = myInt}
		else if let str = try? parent.decode(String.self, forKey: .idAddressDelivery){idAddressDelivery = Int(str)}
		idAddressInvoice = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idAddressInvoice)		{	idAddressInvoice = myInt}
		else if let str = try? parent.decode(String.self, forKey: .idAddressInvoice){	idAddressInvoice = Int(str)}
		idCurrency = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCurrency)			{	idCurrency = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idCurrency)		{	idCurrency = Int(str)	}
		idCustomer = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCustomer)			{	idCustomer = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idCustomer)		{	idCustomer = Int(str)	}
		idGuest = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idGuest)				{	idGuest = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .idGuest)			{	idGuest = Int(str)		}
		idLang = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idLang)				{	idLang = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .idLang)			{	idLang = Int(str)		}
		idShopGroup = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShopGroup)			{	idShopGroup = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idShopGroup)		{	idShopGroup = Int(str)	}
		idShop = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShop)				{	idShop = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .idShop)			{	idShop = Int(str)		}
		idCarrier = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCarrier)				{	idCarrier = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idCarrier)		{	idCarrier = Int(str)	}
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
		if let myInt = try? parent.decode(String.self, forKey: .giftMessage)		{	giftMessage = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .giftMessage)			{	giftMessage = ""		}
		mobileTheme = false
		if let myInt = try? parent.decode(Bool.self, forKey: .mobileTheme)
		{
			mobileTheme = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .mobileTheme)
		{
			mobileTheme = str != "0"
		}
		deliveryOption = ""
		if let myInt = try? parent.decode(String.self, forKey: .deliveryOption)		{	deliveryOption = myInt	}
		else if let _ = try? parent.decode(Bool.self, forKey: .deliveryOption)		{	deliveryOption = ""		}
		secureKey = 0
		if let myInt = try? parent.decode(Int.self, forKey: .secureKey)				{	secureKey = Int32(myInt)}
		else if let str = try? parent.decode(String.self, forKey: .secureKey)		{	secureKey = Int32(str)	}
		allowSeperatedPackage = false
		if let myInt = try? parent.decode(Bool.self, forKey: .allowSeperatedPackage)
		{
			allowSeperatedPackage = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .allowSeperatedPackage)
		{
			allowSeperatedPackage = str != "0"
		}
		dateAdd = ""
		if let myInt = try? parent.decode(String.self, forKey: .dateAdd)			{	dateAdd = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .dateAdd)				{	dateAdd = ""			}
		dateUpd = ""
		if let myInt = try? parent.decode(String.self, forKey: .dateUpd)			{	dateUpd = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .dateUpd)				{	dateUpd = ""			}
		associations = try? parent.decode(CartAssociations.self, forKey: .associations)
	}
}
struct Carts: Decodable
{
	let carts: [aCart]?
}
