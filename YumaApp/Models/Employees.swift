//
//  Employees.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Employees: Codable
{
	let employees: [Employee]?
}
struct Employee: Codable
{
	let id: 						Int?
	let id_lang: 					String?// xlink:href="http://yumatechnical.com/api/languages/1">1</id_lang>
	let last_passwd_gen: 			String?//>2016-12-18 16:19:48
	let stats_date_from: 			String?
	let stats_date_to: 				String?
	let stats_compare_from: 		String?
	let stats_compare_to: 			String?
	let passwd: 					String?//$2y$10$0ZuOdh0SgbPa6GQzGRuZc.kSq8DXNa15j8i4Iy/IN6OP86dC1B1PK
	let lastname: 					String?
	let firstname: 					String?
	let email: 						String?
	let active: 					String?
	let optin: 						String?
	let id_profile: 				String?
	let bo_color: 					String?
	let default_tab: 				String?
	let bo_theme: 					String?
	let bo_css: 					String?//admin-theme.css
	let bo_width: 					String?
	let bo_menu: 					String?
	let stats_compare_option: 		String?
	let preselect_date_range: 		String?
	let id_last_order: 				String?
	let id_last_customer_message: 	String?
	let id_last_customer: 			String?
	let reset_password_token: 		String?
	let reset_password_validity: 	String?
}
