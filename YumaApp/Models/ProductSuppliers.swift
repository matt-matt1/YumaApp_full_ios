//
//  ProductSuppliers.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductSuppliers: Codable
{
	let product_suppliers: [ProductSupplier]?
}
struct ProductSupplier: Codable
{
	let id: 						Int?
	let id_product: 				String?
	let id_product_attribute: 		String?
	let id_supplier: 				String?
	let id_currency: 				String?
	let product_supplier_reference: String?
	let product_supplier_price_te: 	String?
}
