//
//  OrderDetail.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct OrderDetail: Decodable
{
	let id: 							Int
	let id_order: 						String
	let product_id: 					String?
	let product_attribute_id: 			String?
	let product_quantity_reinjected: 	String?
	let group_reduction: 				String?//Float
	let discount_quantity_applied: 		String?//Int
	let download_hash: 					String?//object
	let download_deadline: 				String?
	let id_order_invoice: 				String?
	let id_warehouse: 					String
	let id_shop: 						String
	let id_customization: 				String?
	let product_name: 					String
	let product_quantity: 				String//Int
	let product_quantity_in_stock: 		String?//Int
	let product_quantity_return: 		String?//Int
	let product_quantity_refunded: 		String?//Int
	let product_price: 					String
	let reduction_percent: 				String?//Float
	let reduction_amount: 				String?
	let reduction_amount_tax_incl: 		String?
	let reduction_amount_tax_excl: 		String?
	let product_quantity_discount: 		String?//Float
	let product_ean13: 					String?//object
	let product_isbn: 					String?//object
	let product_upc: 					String?//object
	let product_reference: 				String?
	let product_supplier_reference: 	String?//object
	let product_weight: 				String?//Float
	let tax_computation_method: 		String?
	let id_tax_rules_group: 			String?//Int
	let ecotax: 						String?//Float
	let ecotax_tax_rate: 				String?//Float
	let download_nb: 					String?//Int
	let unit_price_tax_incl: 			String?
	let unit_price_tax_excl: 			String?
	let total_price_tax_incl: 			String?
	let total_price_tax_excl: 			String?
	let total_shipping_price_tax_excl: 	String?
	let total_shipping_price_tax_incl: 	String?
	let purchase_supplier_price: 		String?
	let original_product_price: 		String?
	let original_wholesale_price: 		String?
	let taxes: 							Tax?
}
struct orderDetails: Decodable
{
	let orderDetails: [OrderDetail]?
}
