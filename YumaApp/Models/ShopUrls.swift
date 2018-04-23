//
//  ShopUrls.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ShopUrls: Codable
{
	let shop_urls: [ShopUrl]?
}
struct ShopUrl: Codable
{
	let id: 			Int?
	let id_shop: 		String?
	let active: 		String?
	let main: 			String?
	let domain: 		String?
	let domain_ssl: 	String?
	let physical_uri: 	String?
	let virtual_uri: 	String?
}
