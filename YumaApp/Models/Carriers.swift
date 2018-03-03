//
//  Carriers.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public struct Carrier: Decodable//, Comparable
{
//	public static func <(lhs: Carrier, rhs: Carrier) -> Bool
//	{
//		<#code#>
//	}
//	
//	public static func ==(lhs: Carrier, rhs: Carrier) -> Bool
//	{
//		<#code#>
//	}
	
	let id: String//Int;//":1,"
	let deleted: String;//":"0","
	let is_module: String;//":"0","
	let id_tax_rules_group: String;//":"1","
	let id_reference: String;//":"1","
	let name: String;//":"Yuma Technical Store","
	let active: String;//":"1","
	let is_free: String;//":"1","
	let url: String;//":null,"
	let shipping_handling: String;//":"0","
	let shipping_external: String;//":"0","
	let range_behavior: String;//":"0","
	let shipping_method: Int;//":1,"
	let max_width: String;//":"0","
	let max_height: String;//":"0","
	let max_depth: String;//":"0","
	let max_weight: String;//":"0.000000","
	let grade: String;//":"0","
	let external_module_name: String;//":null,"
	let need_range: String;//":"0","
	let position: String;//":"0","
	let idValue: [IdValue];//":[{"id":"1","value":"Pick up in-store"},{"id":"2","value":"Retrait en magasin"}]},{"id":3,"deleted":"0","is_module":"0","id_tax_rules_group":"1","id_reference":"2","name":"My carrier","active":"1","is_free":"0","url":null,"shipping_handling":"1","shipping_external":"0","range_behavior":"0","shipping_method":"2","max_width":"0","max_height":"0","max_depth":"0","max_weight":"0.000000","grade":"0","external_module_name":null,"need_range":"0","position":"1","idValue":[{"id":"1","value":"Delivery next day!"},{"id":"2","value":"Livraison le lendemain !"}]},{"id":2,"deleted":"1","is_module":"0","id_tax_rules_group":"1","id_reference":"2","name":"My carrier","active":"1","is_free":"0","url":null,"shipping_handling":"1","shipping_external":"0","range_behavior":"0","shipping_method":"1","max_width":"0","max_height":"0","max_depth":"0","max_weight":"0.000000","grade":"0","external_module_name":null,"need_range":"0","position":"1","idValue":[{"id":"1","value":"Delivery next day!"},{"id":"2","value":"Livraison le lendemain !"}]}]}
}


struct CarrierList: Decodable
{
	let carriers: [Carrier]
}
