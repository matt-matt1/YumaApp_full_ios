//
//  AddressesJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Address: Codable
{
	var id: 				Int?
	var idCustomer: 		Int?
	var idManufacturer: 	Int?
	var idSupplier: 		Int?
	var idWarehouse: 		Int?
	var idCountry: 			Int?
	var idState: 			Int?
	var alias: 				String?//..32
	var company: 			String?//..255
	var lastname: 			String?//..32
	var firstname: 			String?//..32
	var vatNumber: 			String?
	var address1: 			String?//..128
	var address2: 			String?//..128
	var postcode: 			String?//..12
	var city: 				String?//..64
	var other: 				String?//..300
	var phone: 				String?//..32
	var phoneMobile: 		String?//..32
	var dni: 				String?//..16
	var deleted: 			Bool?//Bool
	var dateAdd: 			Date?//date
	var dateUpd: 			Date?//date

	init(id: Int?, idCustomer: Int?, idManufacturer: Int?, idSupplier: Int?, idWarehouse: Int?, idCountry: Int?, idState: Int?, alias: String?, company: String?, lastname: String?, firstname: String?, vatNumber: String?, address1: String?, address2: String?, postcode: String?, city: String?, other: String?, phone: String?, phoneMobile: String?, dni: String?, deleted: Bool?, dateAdd: Date?, dateUpd: Date?)
	{
		self.id = 				id
		self.idCustomer = 		idCustomer
		self.idManufacturer = 	idManufacturer
		self.idSupplier = 		idSupplier
		self.idWarehouse = 		idWarehouse
		self.idCountry = 		idCountry
		self.idState = 			idState
		self.alias = 			alias
		self.company = 			company
		self.lastname = 		lastname
		self.firstname = 		firstname
		self.vatNumber = 		vatNumber
		self.address1 = 		address1
		self.address2 = 		address2
		self.postcode = 		postcode
		self.city = 			city
		self.other = 			other
		self.phone = 			phone
		self.phoneMobile = 		phoneMobile
		self.dni = 				dni
		self.deleted = 			deleted
		self.dateAdd = 			dateAdd
		self.dateUpd = 			dateUpd
	}

	enum CodingKeys: String, CodingKey
	{
		case id
		case idCustomer = 				"id_customer"
		case idManufacturer = 			"id_manufacturer"
		case idSupplier = 				"id_supplier"
		case idWarehouse = 				"id_warehouse"
		case idCountry = 				"id_country"
		case idState = 					"id_state"
		case alias
		case company
		case lastname
		case firstname
		case vatNumber = 				"vat_number"
		case address1
		case address2
		case postcode
		case city
		case other
		case phone
		case phoneMobile = 				"phone_mobile"
		case dni
		case deleted
		case dateAdd = 					"date_add"
		case dateUpd = 					"date_upd"
	}
	public init(from decoder: Decoder) throws
	{
		let parent = try decoder.container(keyedBy: CodingKeys.self)
		id = 0
		if let myNull = try? parent.decodeNil(forKey: .id)
		{
			if !myNull
			{
				if let myInt = try? parent.decode(UInt.self, forKey: .id)		{	id = Int(myInt)			}
				else if let myInt = try? parent.decode(Int.self, forKey: .id)	{	id = myInt				}
				else if let str = try? parent.decode(String.self, forKey: .id)	{	id = Int(str)!			}
			}
		}
		idCustomer = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCustomer)		{	idCustomer = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idCustomer)	{	idCustomer = Int(str)	}
		idManufacturer = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idManufacturer)	{	idManufacturer = myInt	}
		else if let str = try? parent.decode(String.self, forKey: .idManufacturer){idManufacturer = Int(str)}
		idSupplier = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idSupplier)		{	idSupplier = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idSupplier)	{	idSupplier = Int(str)	}
		idWarehouse = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idWarehouse)		{	idWarehouse = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idWarehouse)	{	idWarehouse = Int(str)	}
		idCountry = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idCountry)			{	idCountry = myInt		}
		else if let str = try? parent.decode(String.self, forKey: .idCountry)	{	idCountry = Int(str)	}
		idState = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idState)			{	idState = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .idState)		{	idState = Int(str)		}
		alias = ""
		if let myInt = try? parent.decode(String.self, forKey: .alias)			{	alias = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .alias)			{	alias = ""				}
		company = ""
		if let myInt = try? parent.decode(String.self, forKey: .company)		{	company = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .company)			{	company = ""			}
		lastname = ""
		if let myInt = try? parent.decode(String.self, forKey: .lastname)		{	lastname = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .lastname)		{	lastname = ""			}
		firstname = ""
		if let myInt = try? parent.decode(String.self, forKey: .firstname)		{	firstname = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .firstname)		{	firstname = ""			}
		vatNumber = ""
		if let myInt = try? parent.decode(String.self, forKey: .vatNumber)		{	vatNumber = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .vatNumber)		{	vatNumber = ""			}
		address1 = ""
		if let myInt = try? parent.decode(String.self, forKey: .address1)		{	address1 = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .address1)		{	address1 = ""			}
		address2 = ""
		if let myInt = try? parent.decode(String.self, forKey: .address2)		{	address2 = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .address2)		{	address2 = ""			}
		postcode = ""
		if let myInt = try? parent.decode(String.self, forKey: .postcode)		{	postcode = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .postcode)		{	postcode = ""			}
		city = ""
		if let myInt = try? parent.decode(String.self, forKey: .city)			{	city = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .city)			{	city = ""				}
		other = ""
		if let myInt = try? parent.decode(String.self, forKey: .other)			{	other = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .other)			{	other = ""				}
		phone = ""
		if let myInt = try? parent.decode(String.self, forKey: .phone)			{	phone = myInt			}
		else if let _ = try? parent.decode(Bool.self, forKey: .phone)			{	phone = ""				}
		phoneMobile = ""
		if let myInt = try? parent.decode(String.self, forKey: .phoneMobile)	{	phoneMobile = myInt		}
		else if let _ = try? parent.decode(Bool.self, forKey: .phoneMobile)		{	phoneMobile = ""		}
		dni = ""
		if let myInt = try? parent.decode(String.self, forKey: .dni)			{	dni = myInt				}
		else if let _ = try? parent.decode(Bool.self, forKey: .dni)				{	dni = ""				}
		deleted = false
		if let myInt = try? parent.decode(Bool.self, forKey: .deleted)			{	deleted = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .deleted)		{	deleted = str != "0"	}
		dateAdd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .dateAdd)			{	dateAdd = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .dateAdd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			dateAdd = df.date(from: str)
		}
		dateUpd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .dateUpd)			{	dateUpd = myInt			}
		else if let str = try? parent.decode(String.self, forKey: .dateUpd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			dateUpd = df.date(from: str)
		}
	}
}
struct Addresses: Codable
{
	let addresses: [Address]?
}
