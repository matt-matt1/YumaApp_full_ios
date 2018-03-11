//
//  CustomerJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Group: Codable
{
	let id: String?
}
struct AssociationsCustomer: Codable
{
	let groups: [Group]?
}
struct Customer: Codable
{
	let id: 						String?
	let id_customer: 				String?
	let id_default_group: 			String?
	let id_lang: 					String?
	let newsletter_date_add: 		String?
	let ip_registration_newsletter: String?
	let last_passwd_gen: 			String?//read_only
	let secure_key: 				String?//read_only + md5
	let deleted: 					String?//Bool
	let passwd: 					String//!..60
	let lastname: 					String//!..255
	let firstname: 					String//!..255
	let email: 						String//!
	let id_gender: 					String?
	let birthday: 					String?//bdate
	let newsletter: 				String?//Bool
	let optin: 						String?//Bool
	let website: 					String?//URL
	let company: 					String?
	let siret: 						String?
	let ape: 						String?
	let outstanding_allow_amount: 	String?//Ape
	let show_public_prices: 		String?//Bool
	let id_risk: 					String?//Float
	let max_payment_days: 			String?//Int
	let active: 					String?//Bool
	let note: 						String?//html..65000
	let is_guest: 					String?//Bool
	let id_shop: 					String?
	let id_shop_group: 				String?
	let date_add: 					String?//date
	let date_upd: 					String?//date
	let reset_password_token: 		String?//sha1..40
	let reset_password_validity: 	String?//date
	let associations: 				AssociationsCustomer?
}
