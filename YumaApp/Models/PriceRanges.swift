//
//  PriceRanges.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct PriceRanges: Codable
{
	let price_ranges: [PriceRange]?
}
struct PriceRange: Codable
{
	let id: 		Int?
	let id_carrier: String?
	let delimiter1: String?
	let delimiter2: String?
}
