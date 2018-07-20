//
//  PS_Address.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-30.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PS_Address: ParserBase
{
	var id: 				Int?
	var idCustomer: 		Int?
	var idManufacturer: 	Int?
	var idSupplier: 		Int?
	var idWarehouse: 		Int?
	var idCountry: 			Int?
	var idState: 			Int?
	var alias: 				String?
	var company: 			String?
	var lastname: 			String?
	var firstname: 			String?
	var vatNumber: 			String?
	var address1: 			String?
	var address2: 			String?
	var postcode: 			String?
	var city: 				String?
	var other: 				String?
	var phone: 				String?
	var phoneMobile: 		String?
	var dni: 				String?
	var deleted: 			Bool?
	var dateAdd: 			Date?
	var dateUpd: 			Date?
	

	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		let df = DateFormatter()
		switch elementName
		{
		case "id":
			self.id = Int(foundCharacters)
			break
		case "idCustomer":
			self.idCustomer = Int(foundCharacters)
			break
		case "idManufacturer":
			self.idManufacturer = Int(foundCharacters)
			break
		case "idSupplier":
			self.idSupplier = Int(foundCharacters)
			break
		case "idWarehouse":
			self.idWarehouse = Int(foundCharacters)
			break
		case "idCountry":
			self.idCountry = Int(foundCharacters)
			break
		case "idState":
			self.idState = Int(foundCharacters)
			break
		case "alias":
			self.alias = foundCharacters
			break
		case "company":
			self.company = foundCharacters
			break
		case "lastname":
			self.lastname = foundCharacters
			break
		case "firstname":
			self.firstname = foundCharacters
			break
		case "vatNumber":
			self.vatNumber = foundCharacters
			break
		case "address1":
			self.address1 = foundCharacters
			break
		case "address2":
			self.address2 = foundCharacters
			break
		case "postcode":
			self.postcode = foundCharacters
			break
		case "city":
			self.city = foundCharacters
			break
		case "other":
			self.other = foundCharacters
			break
		case "phone":
			self.phone = foundCharacters
			break
		case "phoneMobile":
			self.phoneMobile = foundCharacters
			break
		case "dni":
			self.dni = foundCharacters
			break
		case "deleted":
			self.deleted = foundCharacters == "1"
			break
		case "dateAdd":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.dateAdd = df.date(from: foundCharacters)
			break
		case "dateUpd":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.dateUpd = df.date(from: foundCharacters)
			break
		default:
			parser.delegate = self.parent
		}
		foundCharacters = ""
	}
	
}
