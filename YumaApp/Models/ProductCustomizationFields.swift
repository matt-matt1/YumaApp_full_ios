//
//  ProductCustomizationFields.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductCustomizationFields: Codable
{
	let product_customization_fields: [ProductCustomizationField]?
	
}
struct ProductCustomizationField: Codable
{
	let id: 		Int?
	let id_product: String?
	let type: 		String?
	let required: 	String?
	let is_module: 	String?
	let is_deleted: String?
	let name: 		String?
}
