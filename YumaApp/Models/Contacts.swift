//
//  Contacts.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Contacts: Codable
{
	let contacts: [Contact]?
}
struct Contact: Codable
{
	var id: 				Int?
	var email: 				String?
	var customerService: 	Bool?
	var name: 				[IdValue]?
	var description: 		[IdValue]?
	
	enum CodingKeys: String, CodingKey
	{
		case id
		case email
		case customerService = "customer_service"
		case name
		case description
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
				else if let str = try? parent.decode(String.self, forKey: .id)
				{
					id = Int(str)!
				}
			}
		}
		email = ""
		if let myInt = try? parent.decode(String.self, forKey: .email)
		{
			email = myInt
		}
		else if let _ = try? parent.decode(Bool.self, forKey: .email)
		{
			email = ""
		}
		customerService = false
		if let myInt = try? parent.decode(Bool.self, forKey: .customerService)
		{
			customerService = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .customerService)
		{
			customerService = str != "0"
		}
		name = try? parent.decode([IdValue].self, forKey: .name)
		description = try? parent.decode([IdValue].self, forKey: .description)
	}
}
