//
//  Orders.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct AssociationsOrders
{
	var order_rows: [OrderRow]
}

struct OrderRow
{
	var id: Int
	var product_id: String
	var product_attribute_id: String
	var product_quantity: String
	var product_name: String
	var product_reference: String
	var product_ean13: String
	var product_isbn: String
	var product_upc: String
	var product_price: String
	var unit_price_tax_incl: String
	var unit_price_tax_excl: String
}

struct Orders
{
	var id: Int
	var id_address_delivery: String
	var id_address_invoice: String
	var id_cart: String
	var id_currency: String
	var id_lang: String
	var id_customer: String
	var id_carrier: String
	var current_state: String
	var module: String
	var invoice_number: String
	var invoice_date: String
	var delivery_number: String
	var delivery_date: String
	var valid: String
	var date_add: String
	var date_upd: String
	var shipping_number: String
	var id_shop_group: String
	var id_shop: String
	var secure_key: String
	var payment: String
	var recyclable: String
	var gift: String
	var gift_message: String
	var mobile_theme: String
	var total_discounts: String
	var total_discounts_tax_incl: String
	var total_discounts_tax_excl: String
	var total_paid: String
	var total_paid_tax_incl: String
	var total_paid_tax_excl: String
	var total_paid_real: String
	var total_products: String
	var total_products_wt: String
	var total_shipping: String
	var total_shipping_tax_incl: String
	var total_shipping_tax_excl: String
	var carrier_tax_rate: String
	var total_wrapping: String
	var total_wrapping_tax_incl: String
	var total_wrapping_tax_excl: String
	var round_mode: String
	var round_type: String
	var conversion_rate: String
	var reference: String
	var associations: AssociationsOrders
}
