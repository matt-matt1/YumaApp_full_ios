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
	var id: [IdAsString]?
}
struct CustomerAssociations: Codable, XMLIndexerDeserializable
{
	var groups: [CustomerGroup]?
}
struct Customer: Codable, XMLIndexerDeserializable
{
	var id: 						Int?
	var id_customer: 				String?
	var id_default_group: 			String?
	var id_lang: 					String?
	var newsletter_date_add: 		String?
	var ip_registration_newsletter: String?
	var last_passwd_gen: 			String?//read_only
	var secure_key: 				String?//read_only + md5
	var deleted: 					String?//Bool
	var passwd: 					String?//!..60
	var lastname: 					String?//!..255
	var firstname: 					String?//!..255
	var email: 						String?//!
	var id_gender: 					String?
	var birthday: 					String?//bdate
	var newsletter: 				String?//Bool
	var optin: 						String?//Bool
	var website: 					String?//URL
	var company: 					String?
	var siret: 						String?
	var ape: 						String?
	var outstanding_allow_amount: 	String?//Ape
	var show_public_prices: 		String?//Bool
	var id_risk: 					String?//Float
	var max_payment_days: 			String?//Int
	var active: 					String?//Bool
	var note: 						String?//html..65000
	var is_guest: 					String?//Bool
	var id_shop: 					String?
	var id_shop_group: 				String?
	var date_add: 					String?//date
	var date_upd: 					String?//date
	var reset_password_token: 		String?//sha1..40
	var reset_password_validity: 	String?//date
	var associations: 				CustomerAssociations?

	static func deserialize(_ node: XMLIndexer) throws -> Customer
	{
		return try Customer(id: Int(node["id"].value()), id_customer: node["id_customer"].value(), id_default_group: node["id_default_group"].value(), id_lang: node["id_lang"].value(), newsletter_date_add: node["newsletter_date_add"].value(), ip_registration_newsletter: node["ip_registration_newsletter"].value(), last_passwd_gen: node["last_passwd_gen"].value(), secure_key: node["secure_key"].value(), deleted: node["deleted"].value(), passwd: node["passwd"].value(), lastname: node["lastname"].value(), firstname: node["firstname"].value(), email: node["email"].value(), id_gender: node["id_gender"].value(), birthday: node["birthday"].value(), newsletter: node["newsletter"].value(), optin: node["optin"].value(), website: node["website"].value(), company: node["company"].value(), siret: node["siret"].value(), ape: node["ape"].value(), outstanding_allow_amount: node["outstanding_allow_amount"].value(), show_public_prices: node["show_public_prices"].value(), id_risk: node["id_risk"].value(), max_payment_days: node["max_payment_days"].value(), active: node["active"].value(), note: node["note"].value(), is_guest: node["is_guest"].value(), id_shop: node["id_shop"].value(), id_shop_group: node["id_shop_group"].value(), date_add: node["date_add"].value(), date_upd: node["date_upd"].value(), reset_password_token: node["reset_password_token"].value(), reset_password_validity: node["reset_password_validity"].value(), associations: /*CustomerAssociations*//*nil*/node["associations"]["groups"]["group"]["id"].value())
	}
}
struct Customers: Decodable
{
	let customers: [Customer]?
}
