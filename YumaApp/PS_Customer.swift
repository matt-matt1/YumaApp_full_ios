//
//  PS_Customer.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-30.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PS_Customer: ParserBase
{
	var id: 						Int?
	var idCustomer: 				Int?
	var idDefaultGroup: 			Int?
	var idLang: 					Int?
	var newsletterDateAdd: 			Date?
	var ipRegistrationNewsletter: 	String?
	var lastPasswdGen: 				Date?
	var secureKey: 					String?
	var deleted: 					Bool?
	var passwd: 					String?
	var lastname: 					String?
	var firstname: 					String?
	var email: 						String?
	var idGender: 					Int?
	var birthday: 					Date?
	var newsletter: 				Bool?
	var optin: 						Bool?
	var website: 					String?
	var company: 					String?
	var siret: 						String?
	var ape: 						String?
	var outstandingAllowAmount: 	Float?
	var showPublicPrices: 			Bool?
	var idRisk: 					Int?
	var maxPaymentDays: 			Int?
	var active: 					Bool?
	var note: 						String?
	var isGuest: 					Bool?
	var idShop: 					Int?
	var idShopGroup: 				Int?
	var dateAdd: 					Date?
	var dateUpd: 					Date?
	var resetPasswordToken: 		String?
	var resetPasswordValidity: 		Date?
//	var associations: 				PS_CustomerAssociations?
//	var groups: 					[PS_CustomerAssociationsGroups] = []
	var group: 						[IdValue] = []

	
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
		case "idDefaultGroup":
			self.idDefaultGroup = Int(foundCharacters)
			break
		case "idLang":
			self.idLang = Int(foundCharacters)
			break
		case "newsletterDateAdd":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.newsletterDateAdd = df.date(from: foundCharacters)
			break
		case "ipRegistrationNewsletter":
			self.ipRegistrationNewsletter = foundCharacters
			break
		case "lastPasswdGen":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.lastPasswdGen = df.date(from: foundCharacters)
			break
		case "secureKey":
			self.secureKey = foundCharacters
			break
		case "deleted":
			self.deleted = foundCharacters == "1"
			break
		case "passwd":
			self.passwd = foundCharacters
			break
		case "lastname":
			self.lastname = foundCharacters
			break
		case "firstname":
			self.firstname = foundCharacters
			break
		case "email":
			self.email = foundCharacters
			break
		case "idGender":
			self.idGender = Int(foundCharacters)
			break
		case "birthday":
			df.dateFormat = "yyyy-MM-dd"
			self.birthday = df.date(from: foundCharacters)
			break
		case "newsletter":
			self.newsletter = foundCharacters == "1"
			break
		case "optin":
			self.optin = foundCharacters == "1"
			break
		case "website":
			self.website = foundCharacters
			break
		case "company":
			self.company = foundCharacters
			break
		case "siret":
			self.siret = foundCharacters
			break
		case "ape":
			self.ape = foundCharacters
			break
		case "outstandingAllowAmount":
			self.outstandingAllowAmount = Float(foundCharacters)
			break
		case "showPublicPrices":
			self.showPublicPrices = foundCharacters == "1"
			break
		case "idRisk":
			self.idRisk = Int(foundCharacters)
			break
		case "maxPaymentDays":
			self.maxPaymentDays = Int(foundCharacters)
			break
		case "active":
			self.active = foundCharacters == "1"
			break
		case "note":
			self.note = foundCharacters
			break
		case "isGuest":
			self.isGuest = foundCharacters == "1"
			break
		case "idShop":
			self.idShop = Int(foundCharacters)
			break
		case "idShopGroup":
			self.idShopGroup = Int(foundCharacters)
			break
		case "dateAdd":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.dateAdd = df.date(from: foundCharacters)
			break
		case "dateUpd":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.dateUpd = df.date(from: foundCharacters)
			break
		case "resetPasswordToken":
			self.resetPasswordToken = foundCharacters
			break
		case "resetPasswordValidity":
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			self.resetPasswordValidity = df.date(from: foundCharacters)
			break
		case "associations":
//			let group = PS_CustomerAssocations()
//			self.groups.append(group)
//			parser.delegate = group
//			group.parent = self
			break
		default:
			parser.delegate = self.parent
		}
		
//		if elementName == "message"
//		{
//			self.message = foundCharacters
//		}
//		else if elementName == "code"
//		{
//			if let l = Int(foundCharacters)
//			{
//				self.code = l
//			}
//		}
//		else if elementName == "error"
//		{
//			parser.delegate = self.parent
//		}
		foundCharacters = ""
	}
	
}
