//
//  OrderSlips.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderSlips: Codable
{
	var orderSlips: [OrderSlip]?
	
	enum CodingKeys: String, CodingKey
	{
		case orderSlips = "order_slips"
	}
}
struct OrderSlipAssociations: Codable
{
	var orderSlipDetails: 	[OrderSlipDetail]?//virtualEntity="true"
	
	enum CodingKeys: String, CodingKey
	{
		case orderSlipDetails = "order_slip_details"
	}
}
struct OrderSlipDetail: Codable
{
	var id: 				Int?
	var idOrderDetail: 		Int?//required="true"
	var productQuantity: 	Int?//required="true"
	var amountTaxExcl: 		Int?//required="true"
	var amountTaxIncl: 		Int?//required="true"
	
	enum CodingKeys: String, CodingKey
	{
		case id = 				"id"
		case idOrderDetail = 	"id_order_detail"
		case productQuantity = 	"product_quantity"
		case amountTaxExcl = 	"amount_tax_excl"
		case amountTaxIncl = 	"amount_tax_incl"
	}
	
	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myInt = try? parent.decode(Int.self, forKey: .id)
		{
			id = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .id)
		{
			id = Int(str)
		}
		idOrderDetail = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idOrderDetail)
		{
			idOrderDetail = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idOrderDetail)
		{
			idOrderDetail = Int(str)
		}
		productQuantity = 0
		if let myInt = try? parent.decode(Int.self, forKey: .productQuantity)
		{
			productQuantity = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .productQuantity)
		{
			productQuantity = Int(str)
		}
		amountTaxExcl = 0
		if let myInt = try? parent.decode(Int.self, forKey: .amountTaxExcl)
		{
			amountTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .amountTaxExcl)
		{
			amountTaxExcl = Int(str)
		}
		amountTaxIncl = 0
		if let myInt = try? parent.decode(Int.self, forKey: .amountTaxIncl)
		{
			amountTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .amountTaxIncl)
		{
			amountTaxIncl = Int(str)
		}
	}
}
struct OrderSlip: Codable
{
	var id: 					Int?
	var idCustomer: 			Int?
	var idOrder: 				Int?
	var conversionRate: 		Float?
	var totalProductsTaxExcl: 	Float?
	var totalProductsTaxIncl: 	Float?
	var totalShippingTaxExcl: 	Float?
	var totalShippingTaxIncl: 	Float?
	var amount: 				Float?
	var shippingCost: 			String?
	var shippingCostAmount: 	Float?
	var partial: 				String?
	var dateAdd: 				Date?
	var dateUpd: 				Date?
	var orderSlipType: 			Int?
	var associations:			OrderSlipAssociations?
	
	enum CodingKeys: String, CodingKey
	{
		case id
		case idCustomer = 			"id_customer"
		case idOrder = 				"id_order"
		case conversionRate = 		"conversion_rate"
		case totalProductsTaxExcl = "total_products_tax_excl"
		case totalProductsTaxIncl = "total_products_tax_incl"
		case totalShippingTaxExcl = "total_shipping_tax_excl"
		case totalShippingTaxIncl = "total_shipping_tax_incl"
		case amount
		case shippingCost = 		"shipping_cost"
		case shippingCostAmount = 	"shipping_cost_amount"
		case partial
		case dateAdd = 				"date_add"
		case dateUpd = 				"date_upd"
		case orderSlipType = 		"order_slip_type"
		case associations
	}

	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myInt = try? parent.decode(Int.self, forKey: .id)
		{
			id = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .id)
		{
			id = Int(str)
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
		idOrder = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idOrder)
		{
			idOrder = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idOrder)
		{
			idOrder = Int(str)
		}
		conversionRate = 0
		if let myInt = try? parent.decode(Float.self, forKey: .conversionRate)
		{
			conversionRate = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .conversionRate)
		{
			conversionRate = Float(str)!
		}
		totalProductsTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalProductsTaxExcl)
		{
			totalProductsTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalProductsTaxExcl)
		{
			totalProductsTaxExcl = Float(str)!
		}
		totalProductsTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalProductsTaxIncl)
		{
			totalProductsTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalProductsTaxIncl)
		{
			totalProductsTaxIncl = Float(str)!
		}
		totalShippingTaxExcl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalShippingTaxExcl)
		{
			totalShippingTaxExcl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalShippingTaxExcl)
		{
			totalShippingTaxExcl = Float(str)!
		}
		totalShippingTaxIncl = 0
		if let myInt = try? parent.decode(Float.self, forKey: .totalShippingTaxIncl)
		{
			totalShippingTaxIncl = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .totalShippingTaxIncl)
		{
			totalShippingTaxIncl = Float(str)!
		}
		amount = 0
		if let myInt = try? parent.decode(Float.self, forKey: .amount)
		{
			amount = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .amount)
		{
			amount = Float(str)!
		}
		shippingCost = ""
		if (try? parent.decodeNil(forKey: .shippingCost)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .shippingCost)
			{
				shippingCost = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .shippingCost)
			{
				shippingCost = String(str)
			}
		}
		shippingCostAmount = 0
		if let myInt = try? parent.decode(Float.self, forKey: .shippingCostAmount)
		{
			shippingCostAmount = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .shippingCostAmount)
		{
			shippingCostAmount = Float(str)!
		}
		partial = ""
		if (try? parent.decodeNil(forKey: .partial)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .partial)
			{
				partial = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .partial)
			{
				partial = String(str)
			}
		}
		dateAdd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .dateAdd)
		{
			dateAdd = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .dateAdd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
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
			df.dateFormat = "yyyy-MM-dd"
			dateUpd = df.date(from: str)
		}
		orderSlipType = 0
		if let myInt = try? parent.decode(Int.self, forKey: .orderSlipType)
		{
			orderSlipType = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .orderSlipType)
		{
			orderSlipType = Int(str)
		}
		associations = try parent.decode(OrderSlipAssociations.self, forKey: .associations)
	}
}
