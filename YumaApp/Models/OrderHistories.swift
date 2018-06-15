//
//  OrderHistory.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderHistory: Decodable
{
	var id: 			Int?//!
	var idEmployee: 	Int?
	var idOrderState: 	Int?//!
	var idOrder: 		Int?//!
	var dateAdd: 		Date?
	
	enum CodingKeys: String, CodingKey
	{
		case id
		case idEmployee = 	"id_employee"
		case idOrderState = "id_order_state"
		case idOrder = 		"id_order"
		case dateAdd = 		"date_add"
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
		idEmployee = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idEmployee)
		{
			idEmployee = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idEmployee)
		{
			idEmployee = Int(str)
		}
		idOrderState = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idOrderState)
		{
			idOrderState = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idOrderState)
		{
			idOrderState = Int(str)
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
	}
}
struct OrderHistories: Decodable
{
	let order_histories: [OrderHistory]?
}
