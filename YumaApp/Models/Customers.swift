//
//  CustomerJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import SWXMLHash


//struct CustomerGroupId: Codable, XMLIndexerDeserializable
//{
//	var id: IdAsString?
//}
struct CustomerGroup: Codable, XMLIndexerDeserializable
{
//	var group: [CustomerGroupId]?
	var id: IdAsString?
}
struct CustomerAssociations: Codable, XMLIndexerDeserializable
{
	var groups: [CustomerGroup]?
}
struct Customer: Codable, XMLIndexerDeserializable
{
	var id: 						Int?
	var idCustomer: 				Int?
	var idDefaultGroup: 			Int?
	var idLang: 					Int?
	var newsletterDateAdd: 			Date?
	var ipRegistrationNewsletter: 	String?
	var lastPasswdGen: 				Date?//read_only
	var secureKey: 					String?//read_only + md5
	var deleted: 					Bool?//Bool
	var passwd: 					String?//!..60
	var lastname: 					String?//!..255
	var firstname: 					String?//!..255
	var email: 						String?//!
	var idGender: 					Int?
	var birthday: 					Date?//bdate
	var newsletter: 				Bool?//Bool
	var optin: 						Bool?//Bool
	var website: 					String?//URL
	var company: 					String?
	var siret: 						String?
	var ape: 						String?
	var outstandingAllowAmount: 	Float?//Ape
	var showPublicPrices: 			Bool?//Bool
	var idRisk: 					Int?//Float
	var maxPaymentDays: 			Int?//Int
	var active: 					Bool?//Bool
	var note: 						String?//html..65000
	var isGuest: 					Bool?//Bool
	var idShop: 					Int?
	var idShopGroup: 				Int?
	var dateAdd: 					Date?//date
	var dateUpd: 					Date?//date
	var resetPasswordToken: 		String?//sha1..40
	var resetPasswordValidity: 		Date?//date
	var associations: 				CustomerAssociations?

	enum CodingKeys: String, CodingKey
	{
		case id
		case idCustomer = 					"id_customer"
		case idDefaultGroup = 				"id_default_group"
		case idLang = 						"id_lang"
		case newsletterDateAdd = 			"newsletter_date_add"
		case ipRegistrationNewsletter = 	"ip_registration_newsletter"
		case lastPasswdGen = 				"last_passwd_gen"
		case secureKey = 					"secure_key"
		case deleted
		case passwd
		case lastname
		case firstname
		case email
		case idGender = 					"id_gender"
		case birthday
		case newsletter
		case optin
		case website
		case company
		case siret
		case ape
		case outstandingAllowAmount = 		"outstanding_allow_amount"
		case showPublicPrices = 			"show_public_prices"
		case idRisk = 						"id_risk"
		case maxPaymentDays = 				"max_payment_days"
		case active
		case note
		case isGuest = 						"is_guest"
		case idShop = 						"id_shop"
		case idShopGroup = 					"id_shop_group"
		case dateAdd = 						"date_add"
		case dateUpd = 						"date_upd"
		case resetPasswordToken = 			"reset_password_token"
		case resetPasswordValidity = 		"reset_password_validity"
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
		idDefaultGroup = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idDefaultGroup)
		{
			idDefaultGroup = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idDefaultGroup)
		{
			idDefaultGroup = Int(str)
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
		newsletterDateAdd = nil
		if let myInt = try? parent.decode(Date.self, forKey: .newsletterDateAdd)
		{
			newsletterDateAdd = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .newsletterDateAdd)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			newsletterDateAdd = df.date(from: str)
		}
		ipRegistrationNewsletter = ""
		if (try? parent.decodeNil(forKey: .ipRegistrationNewsletter)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .ipRegistrationNewsletter)
			{
				ipRegistrationNewsletter = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .ipRegistrationNewsletter)
			{
				ipRegistrationNewsletter = String(str)
			}
		}
		lastPasswdGen = nil
		if let myInt = try? parent.decode(Date.self, forKey: .lastPasswdGen)
		{
			lastPasswdGen = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .lastPasswdGen)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			lastPasswdGen = df.date(from: str)
		}
		secureKey = ""
		if (try? parent.decodeNil(forKey: .secureKey)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .secureKey)
			{
				secureKey = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .secureKey)
			{
				secureKey = String(str)
			}
		}
		deleted = false
		if let myInt = try? parent.decode(Bool.self, forKey: .deleted)
		{
			deleted = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .deleted)
		{
			deleted = str != "0"
		}
		passwd = ""
		if (try? parent.decodeNil(forKey: .passwd)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .passwd)
			{
				passwd = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .passwd)
			{
				passwd = String(str)
			}
		}
		lastname = ""
		if (try? parent.decodeNil(forKey: .lastname)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .lastname)
			{
				lastname = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .lastname)
			{
				lastname = String(str)
			}
		}
		firstname = ""
		if (try? parent.decodeNil(forKey: .firstname)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .firstname)
			{
				firstname = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .firstname)
			{
				firstname = String(str)
			}
		}
		email = ""
		if (try? parent.decodeNil(forKey: .email)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .email)
			{
				email = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .email)
			{
				email = String(str)
			}
		}
		idGender = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idGender)
		{
			idGender = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idGender)
		{
			idGender = Int(str)
		}
		birthday = nil
		if let myInt = try? parent.decode(Date.self, forKey: .birthday)
		{
			birthday = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .birthday)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			birthday = df.date(from: str)
		}
		newsletter = false
		if let myInt = try? parent.decode(Bool.self, forKey: .newsletter)
		{
			newsletter = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .newsletter)
		{
			newsletter = str != "0"
		}
		optin = false
		if let myInt = try? parent.decode(Bool.self, forKey: .optin)
		{
			optin = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .optin)
		{
			optin = str != "0"
		}
		website = ""
		if (try? parent.decodeNil(forKey: .website)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .website)
			{
				website = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .website)
			{
				website = String(str)
			}
		}
		company = ""
		if (try? parent.decodeNil(forKey: .company)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .company)
			{
				company = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .company)
			{
				company = String(str)
			}
		}
		siret = ""
		if (try? parent.decodeNil(forKey: .siret)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .siret)
			{
				siret = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .siret)
			{
				siret = String(str)
			}
		}
		ape = ""
		if (try? parent.decodeNil(forKey: .ape)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .ape)
			{
				ape = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .ape)
			{
				ape = String(str)
			}
		}
		outstandingAllowAmount = 0
		if let myInt = try? parent.decode(Float.self, forKey: .outstandingAllowAmount)
		{
			outstandingAllowAmount = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .outstandingAllowAmount)
		{
			outstandingAllowAmount = Float(str)!
		}
		showPublicPrices = false
		if let myInt = try? parent.decode(Bool.self, forKey: .showPublicPrices)
		{
			showPublicPrices = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .showPublicPrices)
		{
			showPublicPrices = str != "0"
		}
		idRisk = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idRisk)
		{
			idRisk = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idRisk)
		{
			idRisk = Int(str)
		}
		maxPaymentDays = 0
		if let myInt = try? parent.decode(Int.self, forKey: .maxPaymentDays)
		{
			maxPaymentDays = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .maxPaymentDays)
		{
			maxPaymentDays = Int(str)
		}
		active = false
		if let myInt = try? parent.decode(Bool.self, forKey: .active)
		{
			active = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .active)
		{
			active = str != "0"
		}
		note = ""
		if (try? parent.decodeNil(forKey: .note)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .note)
			{
				note = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .note)
			{
				note = String(str)
			}
		}
		isGuest = false
		if let myInt = try? parent.decode(Bool.self, forKey: .isGuest)
		{
			isGuest = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .isGuest)
		{
			isGuest = str != "0"
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
		idShopGroup = 0
		if let myInt = try? parent.decode(Int.self, forKey: .idShopGroup)
		{
			idShopGroup = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .idShopGroup)
		{
			idShopGroup = Int(str)
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
		resetPasswordToken = ""
		if (try? parent.decodeNil(forKey: .resetPasswordToken)) != nil
		{
			if let myInt = try? parent.decode(String.self, forKey: .resetPasswordToken)
			{
				resetPasswordToken = myInt
			}
			else if let str = try? parent.decode(Int.self, forKey: .resetPasswordToken)
			{
				resetPasswordToken = String(str)
			}
		}
		resetPasswordValidity = nil
		if let myInt = try? parent.decode(Date.self, forKey: .resetPasswordValidity)
		{
			resetPasswordValidity = myInt
		}
		else if let str = try? parent.decode(String.self, forKey: .resetPasswordValidity)
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			resetPasswordValidity = df.date(from: str)
		}
		associations = nil
//		associations = try parent.decode(CustomerAssociations.self, forKey: .associations)
	}
	
	init(id: Int, id_customer: Int, id_default_group: Int, id_lang: Int, newsletter_date_add: Date, ip_registration_newsletter: String, last_passwd_gen: Date, secure_key: String, deleted: Bool, passwd: String, lastname: String, firstname: String, email: String, id_gender: Int, birthday: Date, newsletter: Bool, optin: Bool, website: String, company: String, siret: String, ape: String, outstanding_allow_amount: Float, show_public_prices: Bool, id_risk: Int, max_payment_days: Int, active: Bool, note: String, is_guest: Bool, id_shop: Int, id_shop_group: Int, date_add: Date, date_upd: Date, reset_password_token: String, reset_password_validity: Date, associations: CustomerAssociations?)
	{
		self.id = id
		self.idCustomer = id_customer
		self.idDefaultGroup = id_default_group
		self.idLang = id_lang
		self.newsletterDateAdd = newsletter_date_add
		self.ipRegistrationNewsletter = ip_registration_newsletter
		self.lastPasswdGen = last_passwd_gen
		self.secureKey = secure_key
		self.deleted = deleted
		self.passwd = passwd
		self.lastname = lastname
		self.firstname = firstname
		self.email = email
		self.idGender = id_gender
		self.birthday = birthday
		self.website = website
		self.company = company
		self.siret = siret
		self.ape = ape
		self.outstandingAllowAmount = outstanding_allow_amount
		self.showPublicPrices = show_public_prices
		self.idRisk = id_risk
		self.maxPaymentDays = max_payment_days
		self.active = active
		self.note = note
		self.isGuest = is_guest
		self.idShop = id_shop
		self.idShopGroup = id_shop_group
		self.dateAdd = date_add
		self.dateUpd = date_upd
		self.resetPasswordToken = reset_password_token
		self.resetPasswordValidity = reset_password_validity
		self.associations = associations
	}
	init(id: Int, idCustomer: Int, idDefaultGroup: Int, idLang: Int, newsletterDateAdd: Date, ipRegistrationNewsletter: String, lastPasswdGen: Date, secureKey: String, deleted: Bool, passwd: String, lastname: String, firstname: String, email: String, idGender: Int, birthday: Date, newsletter: Bool, optin: Bool, website: String, company: String, siret: String, ape: String, outstandingAllowAmount: Float, showPublicPrices: Bool, idRisk: Int, maxPaymentDays: Int, active: Bool, note: String, isGuest: Bool, idShop: Int, idShopGroup: Int, dateAdd: Date, dateUpd: Date, resetPasswordToken: String, resetPasswordValidity: Date, associations: CustomerAssociations?)
	{
		self.id = id
		self.idCustomer = idCustomer
		self.idDefaultGroup = idDefaultGroup
		self.idLang = idLang
		self.newsletterDateAdd = newsletterDateAdd
		self.ipRegistrationNewsletter = ipRegistrationNewsletter
		self.lastPasswdGen = lastPasswdGen
		self.secureKey = secureKey
		self.deleted = deleted
		self.passwd = passwd
		self.lastname = lastname
		self.firstname = firstname
		self.email = email
		self.idGender = idGender
		self.birthday = birthday
		self.website = website
		self.company = company
		self.siret = siret
		self.ape = ape
		self.outstandingAllowAmount = outstandingAllowAmount
		self.showPublicPrices = showPublicPrices
		self.idRisk = idRisk
		self.maxPaymentDays = maxPaymentDays
		self.active = active
		self.note = note
		self.isGuest = isGuest
		self.idShop = idShop
		self.idShopGroup = idShopGroup
		self.dateAdd = dateAdd
		self.dateUpd = dateUpd
		self.resetPasswordToken = resetPasswordToken
		self.resetPasswordValidity = resetPasswordValidity
		self.associations = associations
	}

//	func copy(with zone: NSZone? = nil) -> Any
//	{
////		let copy = Customer(id: id, idCustomer: idCustomer, idDefaultGroup: idDefaultGroup, idLang: idLang, newsletterDateAdd: newsletterDateAdd, ipRegistrationNewsletter: ipRegistrationNewsletter, lastPasswdGen: lastPasswdGen, secureKey: secureKey, deleted: deleted, passwd: passwd, lastname: lastname, firstname: firstname, email: email, idGender: idGender, birthday: birthday, newsletter: newsletter, optin: optin, website: website, company: company, siret: siret, ape: ape, outstandingAllowAmount: outstandingAllowAmount, showPublicPrices: showPublicPrices, idRisk: idRisk, maxPaymentDays: maxPaymentDays, active: active, note: note, isGuest: isGuest, idShop: idShop, idShopGroup: idShopGroup, dateAdd: dateAdd, dateUpd: dateUpd, resetPasswordToken: resetPasswordToken, resetPasswordValidity: resetPasswordValidity, associations: associations)
//		let copy = Customer(id: id!, idCustomer: idCustomer!, idDefaultGroup: idDefaultGroup!, idLang: idLang!, newsletterDateAdd: newsletterDateAdd!, ipRegistrationNewsletter: ipRegistrationNewsletter!, lastPasswdGen: lastPasswdGen!, secureKey: secureKey!, deleted: deleted!, passwd: passwd, lastname: lastname, firstname: firstname, email: email, idGender: idGender, birthday: birthday, newsletter: newsletter, optin: optin, website: website, company: company, siret: siret, ape: ape, outstandingAllowAmount: outstandingAllowAmount, showPublicPrices: showPublicPrices, idRisk: idRisk, maxPaymentDays: maxPaymentDays, active: active, note: note, isGuest: isGuest, idShop: idShop, idShopGroup: idShopGroup, dateAdd: dateAdd, dateUpd: dateUpd, resetPasswordToken: resetPasswordToken, resetPasswordValidity: resetPasswordValidity, associations: associations)
////		let copy = Customer(id: id!, idCustomer: idCustomer!, idDefaultGroup: idDefaultGroup!, idLang: idLang!, newsletterDateAdd: newsletterDateAdd!, ipRegistrationNewsletter: ipRegistrationNewsletter!, lastPasswdGen: lastPasswdGen!, secureKey: secureKey!, deleted: deleted!, passwd: passwd!, lastname: lastname!, firstname: firstname!, email: email!, idGender: idGender!, birthday: birthday!, newsletter: newsletter!, optin: optin!, website: website!, company: company!, siret: siret!, ape: ape!, outstandingAllowAmount: outstandingAllowAmount!, showPublicPrices: showPublicPrices!, idRisk: idRisk!, maxPaymentDays: maxPaymentDays!, active: active!, note: note!, isGuest: isGuest!, idShop: idShop!, idShopGroup: idShopGroup!, dateAdd: dateAdd!, dateUpd: dateUpd!, resetPasswordToken: resetPasswordToken!, resetPasswordValidity: resetPasswordValidity!, associations: associations!)
//		return copy
//	}

	static func deserialize(_ node: XMLIndexer) throws -> Customer
	{
		let date_full = DateFormatter()
		date_full.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date_only = DateFormatter()
		date_only.dateFormat = "yyyy-MM-dd"
		return try Customer(id: node["id"].value(), id_customer: node["id_customer"].value(), id_default_group: node["id_default_group"].value(), id_lang: node["id_lang"].value(), newsletter_date_add: date_full.date(from: node["newsletter_date_add"].value())!, ip_registration_newsletter: node["ip_registration_newsletter"].value(), last_passwd_gen: date_full.date(from: node["last_passwd_gen"].value())!, secure_key: node["secure_key"].value(), deleted: node["deleted"].value(), passwd: node["passwd"].value(), lastname: node["lastname"].value(), firstname: node["firstname"].value(), email: node["email"].value(), id_gender: node["id_gender"].value(), birthday: date_only.date(from: node["birthday"].value())!, newsletter: node["newsletter"].value(), optin: node["optin"].value(), website: node["website"].value(), company: node["company"].value(), siret: node["siret"].value(), ape: node["ape"].value(), outstanding_allow_amount: node["outstanding_allow_amount"].value(), show_public_prices: node["show_public_prices"].value(), id_risk: node["id_risk"].value(), max_payment_days: node["max_payment_days"].value(), active: node["active"].value(), note: node["note"].value(), is_guest: node["is_guest"].value(), id_shop: node["id_shop"].value(), id_shop_group: node["id_shop_group"].value(), date_add: date_full.date(from: node["date_add"].value())!, date_upd: date_full.date(from: node["date_upd"].value())!, reset_password_token: node["reset_password_token"].value(), reset_password_validity: date_full.date(from: node["reset_password_validity"].value())!, associations: /*CustomerAssociations*//*nil*/node["associations"]["groups"]["group"]["id"].value())
	}
}
struct Customers: Decodable
{
	let customers: [Customer]?
}
