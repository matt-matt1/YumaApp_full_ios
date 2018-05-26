//
//  CustomerJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CustomerGroup: Codable
{
	var id: IdAsString?
}
struct CustomerAssociations: Codable
{
	var groups: [CustomerGroup]?
}
struct Customer: Codable
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
}
struct Customers: Decodable
{
	let customers: [Customer]?
}
