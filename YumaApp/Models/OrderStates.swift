//
//  OrderStates.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct OrderStates: Decodable
{
	let id: Int//":2,"
	let unremovable: String
	let delivery: String
	let hidden: String
	let send_email: String
	let module_name: String//object
	let invoice: String
	let color: String//":"#32CD32","
	let logable: String
	let shipped: String
	let paid: String
	let pdf_delivery: String
	let pdf_invoice: String
	let deleted: String
	let name: IdValue//":[{"id":"1","value":"Payment accepted"},{"id":"2","value":"Paiement accepté"}]
	let template: IdValue//":[{"id":"1","value":"payment"},{"id":"2","value":"payment"}]
}
