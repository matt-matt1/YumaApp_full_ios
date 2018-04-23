//
//  CMS.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CMS: Codable
{
	let content_management_system: [aCMS]?
}
struct aCMS: Codable
{
	let id: 				Int?
	let id_cms_category: 	String?
	let position: 			String?
	let indexation: 		String?
	let active: 			String?
	let meta_description: 	IdValue?//<language id="1" xlink:href="http://yumatechnical.com/api/languages/1">Our terms and conditions of delivery</language><language id="2" xlink:href="http://yumatechnical.com/api/languages/2">Nos conditions de livraison</language></meta_description>
	let meta_keywords: 		IdValue?
	let meta_title: 		IdValue?
	let link_rewrite: 		IdValue?
	let content: 			IdValue?
}
