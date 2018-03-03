//
//  OrderInvoice.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderInvoice: Decodable
{
	let id: String
	let id_order: String
	let number: String
	let delivery_number: String
	let delivery_date: String
	let total_discount_tax_excl: String
	let total_discount_tax_incl: String
	let total_paid_tax_excl: String
	let total_paid_tax_incl: String
	let total_products: String
	let total_products_wt: String
	let total_shipping_tax_excl: String
	let total_shipping_tax_incl: String
	let shipping_tax_computation_method: String
	let total_wrapping_tax_excl: String
	let total_wrapping_tax_incl: String
	let shop_address: String
	let note: String
	let date_add: String
}
struct OrderInvoices: Decodable
{
	let invoices: [OrderInvoice]
}
