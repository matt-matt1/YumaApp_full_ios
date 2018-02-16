//
//  CustomerJSON.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Group: Decodable
{
	let id: String?
}

struct AssociationsCustomer: Decodable
{
	let groups: [Group]?
}

struct Customer: Decodable
{
	let id: String?
	let id_customer: String?
	let id_default_group: String?
	let id_lang: String?
	let newsletter_date_add: String?
	let ip_registration_newsletter: String?//AnyObject
	let last_passwd_gen: String?
	let secure_key: String?
	let deleted: String?
	let passwd: String?
	let lastname: String?
	let firstname: String?
	let email: String?
	let id_gender: String?
	let birthday: String?
	let newsletter: String?
	let optin: String?
	let website: String?//AnyObject
	let company: String?//AnyObject
	let siret: String?//AnyObject
	let ape: String?//AnyObject
	let outstanding_allow_amount: String?
	let show_public_prices: String?
	let id_risk: String?
	let max_payment_days: String?
	let active: String?
	let note: String?//AnyObject
	let is_guest: String?
	let id_shop: String?
	let id_shop_group: String?
	let date_add: String?
	let date_upd: String?
	let reset_password_token: String?//AnyObject
	let reset_password_validity: String?
	let associations: AssociationsCustomer?
}
